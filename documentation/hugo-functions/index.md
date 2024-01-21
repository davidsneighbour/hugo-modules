---
title: Functions
linkTitle: hugo-functions
description: ""
summary: ""
date: 2022-08-16T20:28:30+07:00
publishDate: 2022-08-16T20:28:30+07:00
lastmod: 2024-01-21T19:09:06+07:00
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
<!--- INSTALLUPDATE END --->

### Working principle

While being named `functions` this component adds merely partials that return values. In these partials calculations are done, so we might un-nerdily call them functions.

### Available Functions

- [formatOrdinalDate](/davidsneighbour/hugo-functions/wiki/function-formatordinaldate)
- [getAttributesFromTitle](/davidsneighbour/hugo-functions/wiki/function-getattributesfromtitle)
- [getConfiguration](/davidsneighbour/hugo-functions/wiki/function-getconfiguration)
- [getDescription](/davidsneighbour/hugo-functions/wiki/function-getdescription)
- [getGitHash](/davidsneighbour/hugo-functions/wiki/function-getgithash)
- [getInner](/davidsneighbour/hugo-functions/wiki/function-getinner)
- [getJavscript](/davidsneighbour/hugo-functions/wiki/function-getjavascript)
- [getJavascriptByBuild](/davidsneighbour/hugo-functions/wiki/function-getjavascriptbybuild)
- [getRandomString](/davidsneighbour/hugo-functions/wiki/function-getrandomstring)
- [getReadingTime](/davidsneighbour/hugo-functions/wiki/function-getreadingtime)
- [getRemoteImage](/davidsneighbour/hugo-functions/wiki/function-getremoteimage)
- [getStylesheet](/davidsneighbour/hugo-functions/wiki/function-getstylesheet)
- [getYear](/davidsneighbour/hugo-functions/wiki/function-getyear)
- [isCJK](/davidsneighbour/hugo-functions/wiki/function-iscjk)
- [printCommentHeader](/davidsneighbour/hugo-functions/wiki/function-printcommentheader)
- [truncate](/davidsneighbour/hugo-functions/wiki/function-truncate)
