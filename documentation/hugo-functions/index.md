---
title: Functions
linkTitle: hugo-functions
description: ""
summary: ""
date: 2022-08-16T20:28:30+07:00
publishDate: 2022-08-16T20:28:30+07:00
lastmod: 2024-01-21T19:12:46+07:00
resources:
- src: header-card.png
categories:
- components
tags:
- gohugo
- component
- content
config:
  band: gohugo
---

This documentation is work in progress. Please check back later.

A GoHugo theme component with helper functions for other projects.

## Some things you need to know

These are notes about conventions in this README.md. You might want to make yourself acquainted with them if this is your first visit.

<details>

<summary>:heavy_exclamation_mark: A note about proper configuration formatting. Click to expand!</summary>

The following documentation will refer to all configuration parameters in TOML format and with the assumption of a configuration file for your project at `/config.toml`. There are various formats of configurations (TOML/YAML/JSON) and multiple locations your configuration can reside (config file or config directory). Note that in the case of a config directory the section headers of all samples need to have the respective section title removed. So `[params.dnb.something]` will become `[dnb.something]` if the configuration is done in the file `/config/$CONFIGNAME/params.toml`.

</details>

## Installing

First enable modules in your own repository if you did not already have done so:

```bash
hugo mod init github.com/username/reponame
```

Then add this module to your required modules in `config.toml`.

```toml
[module]

[[module.imports]]
path = "github.com/davidsneighbour/hugo-functions"
disable = false
ignoreConfig = false
ignoreImports = false

```

The next time you run `hugo` it will download the latest version of the module.

## Updating

```bash
# update this module
hugo mod get -u github.com/davidsneighbour/hugo-functions
# update to a specific version
hugo mod get -u github.com/davidsneighbour/hugo-functions@v1.0.0
# update all modules recursively over the whole project
hugo mod get -u ./...
```

### Working principle

While being named `functions` this component adds merely partials that return values. In these partials calculations are done, so we might un-nerdily call them functions. The reason for this is that Hugo does not allow for functions to be added to a theme component. So we are using partials instead.
