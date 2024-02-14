![](../../documentation/netlification/header-card.png)

This is a Hugo theme component with helpers to host your [GoHugo](https://gohugo.io/) generated static website on [Netlify](https://www.netlify.com/). If you don't use Netlify, you DO NOT need this module.

# Features

**Redirects:** Adds redirects via HTTP headers. This redirection is faster and SEO wise better than Hugo's method of adding `meta-refresh` commands in dedicated files.

**CSP:** Adds Content Security Policies for improved security.

**Headers:** Adds headers with caching and security directives to improves security and speed.

# Installation and setup

**Step 1:** enable modules in your own repository

```bash
hugo mod init github.com/username/reponame
```

**Step 2:** add the module to your required modules in `config.toml`:

```toml
[module]
[[module.imports]]
path = "github.com/davidsneighbour/hugo-netlification"
```

or in your `config/module.toml`:

```toml
[[imports]]
path = "github.com/davidsneighbour/hugo-netlification"
```

The next time you run hugo it will download the latest version of the module.

**Step 3:** Add `REDIR` and `HEADERS` to your home output formats:

```toml
[outputs]
home = [ ... others ... , "REDIR", "HEADERS" ]
```

You should already have an `[outputs]` section, add `"REDIR", "HEADERS"` to it. Add them to the `home` parameter, not to other definitions.

# Configuration

## Redirects

### Per post

Redirection takes aliases that are defined in the pages frontmatter and creates a 301 redirect for them. This is done via HTTP headers as opposed to the redirects via HTML meta tags that Hugo is doing. This is faster and might be better for SEO.

Keep defining them via frontmatter and let _Netlification_ do the rest.

```yaml
aliases:
  - url1
  - url2
  - url3
```

### Additional Redirects

- A redirect for 404 errors to Hugo's 404 page (`/layouts/404.html`) - no action by you required

- A redirect for your default netlify.com URL to your live URL via data configuration in `data/dnb/netlification/config.toml`

  ```toml
  [[redirects]]
  netlify = "https://eloquent-morse-196fd2.netlify.com/"
  ```

  The URL will be redirected to your `baseURL`. Right now this feature requires a trailing slash on both, baseURL and netlify parameter

- Add more redirects as required. Each redirect requires a header `[[redirects]]` followed by at least the parameters `from` and `to`:

  ```toml
  [[redirects]]
  from = "/old-contact-form/"
  to = "/contact/"
  status = 200
  ```

  You can add a status property, if you wish to output any other code than 301 for the redirect. The status property is optional and is explicitly intended for redirect cases.

  The format of these redirect tables is identical to redirects format used in the [Netlify configuration file format](https://docs.netlify.com/routing/redirects/#syntax-for-the-netlify-configuration-file).

### Disable internal alias creation in Hugo

If you are using Netlification you can speed up Hugo's page creation process a little bit by setting the config variable `disableAliases` to `true`. This will disable the default behaviour of creating an HTML file per alias to redirect via meta tags and speed up site generation.

## Headers

Netlification uses considerate caching options. Stylesheets, javascripts, images and other media files are cached for a full year. Netlification expects you to use Hugo pipes to create those files, which will result in unique URLs after you change the content of the files.

### Content Security Policy

Have a look in [data/dnb/netlification/config.toml](https://github.com/davidsneighbour/hugo-netlification/blob/main/data/dnb/netlification/config.toml) or [data/dnb/netlification/sample-config.toml](https://github.com/davidsneighbour/hugo-netlification/blob/main/data/dnb/netlification/sample-config.toml) to learn more.

You can check your content security policy using these following services and audits:

- [https://csp-evaluator.withgoogle.com/?csp=https://kollitsch.dev](https://csp-evaluator.withgoogle.com/?csp=https://kollitsch.dev)

# Sample Configuration

Add your configuration in `data/dnb/netlification/config.toml`. A sample configuration can be found in [data/dnb/netlification/sample-config.toml](data/dnb/netlification/sample-config.toml)

# Updating

To update this module:

```shell
hugo mod get -u github.com/davidsneighbour/hugo-netlification
```

To update all modules:

```shell
hugo mod get -u
```

# Extend netlification headers from other modules

`hugo-netlification` offers an easy way to plug into the `_headers` file. Just add a file at `/data/namespacename/modulename/netlification.toml` and [follow the instructions about header formats at docs.netlify.com](https://docs.netlify.com/routing/headers/). These rules are added after the rules by `hugo-netlification`.

# Notes

- [Netlify's redirects engine](https://docs.netlify.com/routing/redirects/#rule-processing-order) will process the first matching rule it finds, reading from top to bottom. Rules in the `_redirects` file are always processed first, followed by rules in the Netlify configuration file.

# Testing output
- [Netlify Playground for redirects](https://play.netlify.com/redirects)

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
