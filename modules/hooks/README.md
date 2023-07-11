![](header-card.png)

# DNB GoHugo Component / Hooks

Hooks for GoHugo layouts. An easy way for theme developers to let users add partials and blocks at pre-defined safe places to their themes.

We often want to add locations and places in our templates and layouts where it's users can add something on their own. Be it some code for an analytics script, that arbitrary ad or popup or just some space for call to actions or additional footer sections, a banner at the top of the page or some very specific Javascript code, a separator after each fifth post, a button in each header.

You name it. `hugo-hooks` is what you need. This module adds these hooks to your theme and provides a simple way **any theme developer** can add these "layout locations" to "hook" additional features in.

**You as the end-user** can add simple layout files to "hook" into these locations and add whatever pizzazz, panache, flair or sparkle your website needs.

<!--- THINGSTOKNOW BEGIN --->

## Some things you need to know

These are notes about conventions in this README.md. You might want to make yourself acquainted with them if this is your first visit.

<details>

<summary>:heavy_exclamation_mark: A note about proper configuration formatting. Click to expand!</summary>

The following documentation will refer to all configuration parameters in TOML format and with the assumption of a configuration file for your project at `/config.toml`. There are various formats of configurations (TOML/YAML/JSON) and multiple locations your configuration can reside (config file or config directory). Note that in the case of a config directory the section headers of all samples need to have the respective section title removed. So `[params.dnb.something]` will become `[dnb.something]` if the configuration is done in the file `/config/$CONFIGNAME/params.toml`.

</details>
<!--- THINGSTOKNOW END --->

<!--- INSTALLUPDATE BEGIN --->

## Installing

First enable modules in your own repository if you did not already have done so:

```bash
hugo mod init github.com/username/reponame
```

Then add this module to your required modules in `config.toml`.

```toml
[module]

[[module.imports]]
path = "github.com/davidsneighbour/hugo-hooks"
disable = false
ignoreConfig = false
ignoreImports = false

```

The next time you run `hugo` it will download the latest version of the module.

## Updating

```bash
# update this module
hugo mod get -u github.com/davidsneighbour/hugo-hooks
# update to a specific version
hugo mod get -u github.com/davidsneighbour/hugo-hooks@v1.0.0
# update all modules recursively over the whole project
hugo mod get -u ./...
```
<!--- INSTALLUPDATE END --->

## Hook principle

Theme users save hooks to the `layouts/partials/hooks` directory. There are no errors if a hook is not found (some themes or modules might provide a feedback if their hook is unused and usage of them is required to get important features working).

If a hook has an added `-cached` to it's name then it will be cached and on re-calls be re-used. Check the documentation of the module or theme that introduces the hook to see if it makes sense to cache that specific hook.

For example:

```golang
{{ partial "func/hook.html" "head-start" }}
```

will load `layouts/partials/hooks/head-start.html` and `layouts/partials/hooks/head-start-cached.html`. The non-cached variant will be loaded **BEFORE** the cached one.

You can force caching by loading the hook via `partialCached` instead.

```golang
{{ partialCached "func/hook.html" "head-start" "cachename"}}
```

These hooks currently **do not return any values**, they execute the layouts. To read more about ideas to extend the hooks to return values read [#2 RFC: Hooks that return values](https://github.com/davidsneighbour/hugo-hooks/issues/2).

## Call hooks in layouts

### Simple Calls

Add the hook name as parameter to simple calls. The context inside of the hook layout will have a hook parameter with that name.

```golang
{{- partial "func/hook.html" "hookname" -}}
{{- partialCached "func/hook.html" "hookname" $CACHENAME -}}
```

### Extended Use (adding parameters to the call)

If the hook supports adding parameters you can call it by adding a `dict` object to your call. The `hook` parameter is required, everything else will be passed through as-is to the hook layout. You should always add `"context" .` to add the local layout-context to your parameters. Can't go wrong with that :)

```golang
{{- partial "func/hook.html" ( dict "hook" "hookname" "context" . ) -}}
{{- partialCached "func/hook.html" ( dict "hook" "hookname" "context" . ) $CACHENAME -}}
```

## Configuration

You can configure the module by setting the following options in the `params` section of your configuration:

```toml
[dnb.hooks]
disable_messages = [
  "unused_hooks",
  "running_hooks",
  "running_cached_hooks",
  "running_uncached_hooks",
]
```

**disable_messages**:

-   `unused_hooks` - silences "unused hooks" messages
-   `running_hooks` - silences ALL "running hook x" messages
-   `running_cached_hooks` - silences all "running cached hook x" messages (`false` if `running_hooks` is false)
-   `running_uncached_hooks` - silences all "running uncached hook x" messages (`false` if `running_hooks` is false)

The messages system also uses the methods implemented in `hugo-debug` to silence based on verbosity level.

## Hooks for developers

Implementing the hooks system in your theme or module is easy. There are several ways the system looks for hooks. The following main order is kept:

- hooks in a folder (`layouts/partials/hooks/hook-name/*.html`)
- cached hooks in a folder (`layouts/partials/hooks/hook-name/*-cached.html`)
- hook in a file (`layouts/partials/hooks/hook-name.html`)
- cached hook in a file (`layouts/partials/hooks/hook-name-cached.html`)

### Directory based

### File based

## Best Practices

### "Global" Reusable Hooks

To be very portable between themes the following hooks should be used at the appropriate locations in implementing themes and modules. All of @davidsneighbours GoHugo themes and modules will do so and to support the overall portable format of the underlying idea of the hook system we hope others will too:

| Hookname | Runs | Location |
| :--- | :---: | :--- |
| **setup** | 1 | Runs before anything is put out. Use this hook to set up and configure your scripts. |
| **head-init** | 1 | Runs right after the `<head>` tag. Layouts using this hook should not print anything out so that the three initial head-tags are printed first. Use `head-start` for things you want in the beginning of the page head. |
| **head-start** | 1 | Runs after the three initial head-tags. |
| **head-pre-css** | 1 | Runs inside the head before the stylesheets are added. |
| **head-post-css** | 1 | Runs inside the head after the stylesheets are added. |
| **head-end** | 1 | Runs at the end of the head, before the `</head>` tag. |
| **body-start** | 1 | |
| **container-start** | 1 | |
| **content-start** | 1 | |
| **content-end** | 1 | |
| **container-end** | 1 | |
| **footer-start** | 1 | |
| **footer-inside-start** | 1+ | |
| **footer-widget-start** | 1+ | |
| **footer-widget-end** | 1+ | |
| **footer-inside-end** | 1+ | |
| **footer-end** | 1 | |
| **body-end-pre-script** | 1 | Runs at the end of the body BEFORE the deferred theme javascripts are added. |
| **body-end** | 1 | Runs at the end of the body AFTER the deferred theme javascripts are added and right before the `</body>` tag. |
| **teardown** | 1 | Runs after everything is printed to output. Use this hook to cleanup for your scripts. |

### Namespaced Hooks

For specific modules we advise to use a namespaced hook name (like `dnb-netlification-headers`) to avoid collisions with other modules and hooks. Please document your hooks and refer back to this README so users can dive into the details of the system if required.

### Sample hook usage

Have a look a the following projects to see usage of the hook system:

- [Hooks in the theme of kollitsch.dev](https://github.com/davidsneighbour/kollitsch.dev/search?q=func%2Fhook)

<!--- COMPONENTS BEGIN --->

## Other [GoHugo](https://gohugo.io/) components by [@davidsneighbour](https://github.com/davidsneighbour/)

<!-- prettier-ignore -->
| Component | Description |
| :--- | :--- |
| [hugo-auditor](https://github.com/davidsneighbour/hugo-auditor) | |
| [hugo-debug](https://github.com/davidsneighbour/hugo-debug) :mage_man: | Debug EVERYTHING in GoHugo. |
| [hugo-errors](https://github.com/davidsneighbour/hugo-errors) | A Hugo module that adds more versatile error pages to a site. |
| [hugo-feeds](https://github.com/davidsneighbour/hugo-feeds) | Implements various configurable feed formats. |
| [hugo-functions](https://github.com/davidsneighbour/hugo-functions) | A Hugo theme component with helper functions for other projects. |
| [hugo-giscus](https://github.com/davidsneighbour/hugo-giscus) | The Giscus comment system layout for GoHugo. |
| [hugo-head](https://github.com/davidsneighbour/hugo-head) | A GoHugo theme component that solves the old question of "What tags belong into the `<head>` tag of my website?" |
| [hugo-hooks](https://github.com/davidsneighbour/hugo-hooks) | Hooks for GoHugo layouts. An easy way for theme developers to let users add to their themes.  |
| [hugo-humans](https://github.com/davidsneighbour/hugo-humans) | Your site is made by humans. Humans.txt is naming them. |
| [hugo-icons](https://github.com/davidsneighbour/hugo-icons) | Icons for your Hugo website. |
| [hugo-internals](https://github.com/davidsneighbour/hugo-internals) | Better internal templates for GoHugo |
| [hugo-netlification](https://github.com/davidsneighbour/hugo-netlification) | a collection of tools that optimize your site on Netlify |
| [hugo-opensearch](https://github.com/davidsneighbour/hugo-opensearch) | configuration for Open Search |
| [hugo-pictures](https://github.com/davidsneighbour/hugo-pictures) | |
| [hugo-pwa](https://github.com/davidsneighbour/hugo-pwa) | Automatically turns your site into a PWA |
| [hugo-renderhooks](https://github.com/davidsneighbour/hugo-renderhooks) | render hooks for Markdown markup |
| [hugo-robots](https://github.com/davidsneighbour/hugo-robots) | Add a customizable robots.txt to your website. |
| [hugo-schema](https://github.com/davidsneighbour/hugo-schema) | |
| [hugo-search-algolia](https://github.com/davidsneighbour/hugo-search-algolia) | |
| [hugo-security](https://github.com/davidsneighbour/hugo-security) | Add a security.txt to your site with information about your preferred procedures to notify the developer team about security issues. |
| [hugo-sitemap](https://github.com/davidsneighbour/hugo-sitemap) | |
| [hugo-social](https://github.com/davidsneighbour/hugo-social) | |
| [hugo-workflows](https://github.com/davidsneighbour/hugo-workflows) | A collection of Github Actions/Workflows to optimise your work with GoHugo. |
| [hugo-youtube](https://github.com/davidsneighbour/hugo-youtube) | A shortcode and partial for lite and speedy youtube embeds. |

<!--lint disable no-missing-blank-lines -->
<!--- COMPONENTS END --->
