<!--- CARD BEGIN --->

![DNB-Hugo/HEAD](.github/github-card-dark.png#gh-dark-mode-only)
![DNB-Hugo/HEAD](.github/github-card-light.png#gh-light-mode-only)

<!--- CARD END --->

# David's Neighbour GoHugo Component / Feeds

This is a GoHugo theme component that implements various configurable feed formats. Currently implemented formats are RSS, Atom and JSONfeed.

Find out more about the [RSS](https://cyber.harvard.edu/rss/rss.html), [Atom](https://datatracker.ietf.org/doc/html/rfc4287) and [JSON feed](https://www.jsonfeed.org/version/1.1/) formats

## ToDo

- [x] proper implementation of the formats
  - [x] RSS
  - [x] Atom
  - [x] JSON feed
- [ ] add hooks (for all feed formats or individual feed formats)
- [ ] configurable section-, taxonomy- and term-feeds
- [ ] partial to output list of available feeds on your website
- [ ] proper testing, validation and dev-site

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

First enable modules in your own repository:

```bash
hugo mod init github.com/username/reponame
```

Then add this module to your required modules in config.toml.

```toml
[module]

[[module.imports]]
path = " $MODULENAME$"

```

The next time you run `hugo` it will download the latest version of the module.

## Updating

```shell
# update this module
hugo mod get -u $REPONAME$
# update all modules
hugo mod get -u #
```
<!--- INSTALLUPDATE END --->

## Configuration

### Limits

`hugo-feeds` uses a cautious approach at configuring the output of the feeds. Where GoHugo's internal RSS template prints _all_ available pages without a configured limit, `hugo-feeds` will load only the 10 latest pages/posts, but you can configure at your pleasure.

If either `rssLimit` or `services.rss.limit` is defined and NOT overridden by any other configuration then these values will be choosen for RSS. Limits for specific feed formats can be configured explicitly.

```toml
[dnb]
[dnb.feeds]
limit = 10

[dnb.feeds.atom]
limit = 10

[dnb.feeds.rss]
limit = 10

[dnb.feeds.json]
limit = 10
```

Limits are formatted via integers. 0 disables, everything at 1 and over selects the last x items and -1 will list all items.

### TODO: configuration

```toml
[dnb.feeds]
[dnb.feeds.atom]
[dnb.feeds.rss]
[dnb.feeds.json]
```

### Posts to show in feeds

Set `dnb.feeds.items` to `posts` to show only items that are listed in `params.mainSections` in your feeds. All other values will result in _all_ pages being included.

### Discreet Drafts

Have a read through [@zbetz](https://github.com/zwbetz-gh)'s great article [Discreet Drafts in Hugo](https://zwbetz.com/discreet-drafts-in-hugo/) and rest assured that without configuration this module will hide all drafts (posts with `draft` in their frontmatter set to `true`) from it's feeds. If you wish to force drafts being shown in the feeds then set `dnb.feeds.drafts` to `true`.

## Hooks

`hugo-feeds` implements template hooks via [`hugo-hooks`](https://github.com/davidsneighbour/hugo-hooks) and makes the following hooks available:

<!-- prettier-ignore -->
| Hook | Description |
| --- | :--- |
| feeds-init | Hooks in after the opening tag. Do not open this to output anything. Just for initialising any of your plugins. |
| feeds-start | Hooks in after the initial first tags that define your feeds purpose and before items of the feed are printed. |
| feeds-end | Hooks in at the end of the feed after the items are printed. |

All hooks exist in a second form containing the feed type and will run then only in that format. For example `feeds-atom-init` runs only at the init stage of the atom feed, `feeds-rss-init` in rss and `feed-jsonfeed-init` in JSONfeeds.

<!--- COMPONENTS BEGIN --->

## Other [GoHugo](https://gohugo.io/) components by [@davidsneighbour](https://github.com/davidsneighbour/)

<!-- prettier-ignore -->
| Component | Description |
| :--- | :--- |
| [hugo-auditor](https://github.com/davidsneighbour/hugo-auditor) | |
| [hugo-debug](https://github.com/davidsneighbour/hugo-debug) :mage_man: | |
| [hugo-errors](https://github.com/davidsneighbour/hugo-errors) | |
| [hugo-functions](https://github.com/davidsneighbour/hugo-functions) | |
| [hugo-giscus](https://github.com/davidsneighbour/hugo-giscus) | The Giscus comment system layout for GoHugo. |
| [hugo-head](https://github.com/davidsneighbour/hugo-head) | A GoHugo theme component that solves the old question of "What tags belong into the `<head>` tag of my website?" |
| [hugo-hooks](https://github.com/davidsneighbour/hugo-hooks) | GoHugo's missing hook system for template extensions. |
| [hugo-internals](https://github.com/davidsneighbour/hugo-internals) | Better internal templates for GoHugo |
| [hugo-netlification](https://github.com/davidsneighbour/hugo-netlification) | a collection of tools that optimize your site on Netlify |
| [hugo-opensearch](https://github.com/davidsneighbour/hugo-opensearch) | configuration for Open Search |
| [hugo-pictures](https://github.com/davidsneighbour/hugo-pictures) | |
| [hugo-pwa](https://github.com/davidsneighbour/hugo-pwa) | Automatically turns your site into a PWA |
| [hugo-renderhooks](https://github.com/davidsneighbour/hugo-renderhooks) | render hooks for Markdown markup |
| [hugo-robots](https://github.com/davidsneighbour/hugo-robots) | configure the content of your robots.txt with front matter |
| [hugo-schema](https://github.com/davidsneighbour/hugo-schema) | |
| [hugo-search-algolia](https://github.com/davidsneighbour/hugo-search-algolia) | |
| [hugo-security](https://github.com/davidsneighbour/hugo-security) | |
| [hugo-sitemap](https://github.com/davidsneighbour/hugo-sitemap) | |
| [hugo-social](https://github.com/davidsneighbour/hugo-social) | |

<!--lint disable no-missing-blank-lines -->
<!--- COMPONENTS END --->
