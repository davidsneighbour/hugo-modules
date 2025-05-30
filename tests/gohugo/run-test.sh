#!/usr/bin/env bash
set -euo pipefail

# Global variable for Hugo binary (can be overridden via --hugo-binary)
HUGO_BINARY="hugo"

# Global variable to hold a single module name (if provided)
MODULE_NAME=""

# Flag to indicate we want to test all modules
ALL_MODULES="false"

# Variant flag: default to 'local'
VARIANT="local"

# Function to display help information.
function show_help() {
  cat <<EOF
Usage: $(basename "$0") [--module MODULE_NAME | --all] [--variant VARIANT] [--hugo-binary PATH]
  --module MODULE_NAME   Name of the module to test (e.g. module1)
  --all                  Test all modules found in the modules directory.
  --variant VARIANT      Which configuration variant to use: "local" or "live" (default: local)
  --hugo-binary PATH     Path to the hugo binary (default: hugo)
  --help                 Display this help message.
EOF
}

# Parse command-line arguments.
while [[ $# -gt 0 ]]; do
  case "$1" in
  --module)
    if [[ "$ALL_MODULES" == "true" ]]; then
      echo "Error: --module and --all cannot be used together." >&2
      show_help
      exit 1
    fi
    MODULE_NAME="$2"
    shift 2
    ;;
  --all)
    if [[ -n "$MODULE_NAME" ]]; then
      echo "Error: --module and --all cannot be used together." >&2
      show_help
      exit 1
    fi
    ALL_MODULES="true"
    shift
    ;;
  --variant)
    VARIANT="$2"
    if [[ "$VARIANT" != "local" && "$VARIANT" != "live" ]]; then
      echo "Error: --variant must be either 'local' or 'live'." >&2
      show_help
      exit 1
    fi
    shift 2
    ;;
  --hugo-binary)
    HUGO_BINARY="$2"
    shift 2
    ;;
  --help)
    show_help
    exit 0
    ;;
  *)
    echo "Error: Unknown option: $1" >&2
    show_help
    exit 1
    ;;
  esac
done

# Compute absolute paths for the script directory and repository root.
SCRIPT_PATH=$(realpath "$0")
CURRENT_DIR=$(dirname "$SCRIPT_PATH")
REPO_ROOT=$(realpath "$CURRENT_DIR/../..")

# Change to the directory where the script is located.
cd "$CURRENT_DIR" || {
  echo "Failed to change directory to $CURRENT_DIR."
  exit 1
}

# Build the absolute path for the modules directory.
MODULES_DIR="${REPO_ROOT}/modules"
if [[ ! -d "$MODULES_DIR" ]]; then
  echo "Error: Modules directory not found at $MODULES_DIR."
  exit 1
fi

# Determine the configuration file based on the variant.
CONFIG_TEMPLATE="config/${VARIANT}/hugo.toml"
if [[ ! -f "$CONFIG_TEMPLATE" ]]; then
  echo "Error: Configuration template not found at $CONFIG_TEMPLATE."
  exit 1
fi

# Function to run tests for a given module.
function run_module_test() {
  local module_name="$1"
  echo "=================================================="
  echo "== Testing module: ${module_name} using variant: ${VARIANT}"
  echo "=================================================="

  # Create a config.toml from the selected configuration template.
  if ! sed "s/{{MODULE_NAME}}/${module_name}/g" "$CONFIG_TEMPLATE" >config.toml; then
    echo "Error: Failed to generate config file for module '${module_name}'."
    return 1
  fi
  echo "Generated config.toml for module '${module_name}'."

  # Initialize go.mod if it doesn't exist.
  if [[ ! -f "go.mod" ]]; then
    echo "Initializing go module..."
    if ! go mod init tests/gohugo; then
      echo "Error: Failed to initialize go module."
      return 1
    fi
  fi

  # Module replacement directives are now maintained in the configuration file (for the local variant).

  # Tidy up module dependencies.
  if ! go mod tidy; then
    echo "Error: 'go mod tidy' failed for module '${module_name}'."
    return 1
  fi

  echo "Downloading Hugo modules..."
  if ! $HUGO_BINARY mod get -v; then
    echo "Error: Failed to download Hugo modules for '${module_name}'."
    return 1
  fi

  # Start the Hugo server using content from tests/gohugo/content.
  tmpfile=$(mktemp)
  echo "Starting Hugo server for '${module_name}'..."
  if ! $HUGO_BINARY server --bind=127.0.0.1 --contentDir="$(pwd)/content" >"$tmpfile" 2>&1 & then
    echo "Error: Failed to start Hugo server for '${module_name}'."
    rm "$tmpfile"
    return 1
  fi
  local server_pid=$!

  # Give the server a few seconds to start.
  sleep 5

  # Check the server output for any deprecations, warnings, or errors.
  if grep -Ei "(deprecation|warning|error)" "$tmpfile"; then
    echo "Error: Detected warnings or errors in Hugo server output for module '${module_name}'."
    kill "$server_pid" 2>/dev/null || true
    rm "$tmpfile"
    return 1
  fi

  # Verify that the website is serving valid HTML.
  if curl --silent "http://127.0.0.1:1313" | grep -q "<!DOCTYPE html>"; then
    echo "Module '${module_name}': Hugo server is running and serving content successfully."
  else
    echo "Error: Hugo server did not serve the expected HTML content for module '${module_name}'."
    kill "$server_pid" 2>/dev/null || true
    rm "$tmpfile"
    return 1
  fi

  # Clean up: stop the server and remove the temporary file.
  kill "$server_pid" 2>/dev/null || true
  rm "$tmpfile"
  echo "Module '${module_name}' passed the test."
  return 0
}

# Main logic: either run one module or iterate through all modules.
if [[ "$ALL_MODULES" == "true" ]]; then
  success_count=0
  fail_count=0

  for module_dir in "$MODULES_DIR"/*; do
    if [[ -d "$module_dir" ]]; then
      current_module=$(basename "$module_dir")
      if run_module_test "$current_module"; then
        success_count=$((success_count + 1))
      else
        fail_count=$((fail_count + 1))
      fi
      echo "" # Blank line for readability.
    fi
  done

  echo "=================================================="
  echo "Test Summary: ${success_count} passed, ${fail_count} failed."
  echo "=================================================="

  if [[ $fail_count -gt 0 ]]; then
    exit 1
  else
    exit 0
  fi

else
  if [[ -z "$MODULE_NAME" ]]; then
    echo "Error: Either --module or --all must be provided." >&2
    show_help
    exit 1
  fi
  run_module_test "$MODULE_NAME"
fi
