![](../../documentation/debug/header-card.png)

# GoHugo Modules / Debug

This module for GoHugo adds debugging partials for many use cases.

Read more about it [in the documentation](https://kollitsch.dev/gohugo/debug).

![](.github/sample.jpg)

## Install version based

The latest releases of this module is always based on and works with the latest release of GoHugo. To install the latest release of this module, run:

```bash
hugo mod get -u github.com/davidsneighbour/hugo-modules/modules/debug
```

To install version for older Hugo versions, run the command with the following version tags:

| Hugo Version | Debug Version | Installation Path |
| --- | --- | --- |
| 0.120.0 | v1.2023.19 | `hugo mod get -u github.com/davidsneighbour/hugo-modules/modules/debug@v1.2023.19` |
| 0.129.0 | v1.2024.26 | `hugo mod get -u github.com/davidsneighbour/hugo-modules/modules/debug@v1.2023.26` |

## Breaking changes

* **v1.2023.26:**
  * The partial `debugprint.html` has been renamed to `debug-print.html`. Please update your templates.
  * The partial `debug.html` has been renamed to `debug-cli.html`. Please update your templates.
  * Both deprecated partials were removed after 2024-03-14.
  * The capability of the partials remains the same after renaming.
