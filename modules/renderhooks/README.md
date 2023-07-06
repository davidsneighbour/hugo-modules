<!--- CARD BEGIN --->

![DNB-Hugo/HEAD](.github/github-card-dark.png#gh-dark-mode-only)
![DNB-Hugo/HEAD](.github/github-card-light.png#gh-light-mode-only)

<!--- CARD END --->

# David's Neighbour GoHugo Component / Renderhooks

❗this is work in progress, I just uploaded the current state so I can link to it. The original repo can be found within the revisions of (github.com/dnb-org/components] I think.

Customized render hooks for Hugo

## Installing

Step 1: enable modules in your own repository

```shell script
hugo mod init github.com/username/reponame
```

Step 2: add the module to your required modules in config.toml

```
[module]
[[module.imports]]
path = "github.com/davidsneighbour/hugo-renderhooks"
```

The next time you run hugo it will download the latest version of the module.

## Updating

To update this module:

```
hugo mod get -u github.com/davidsneighbour/hugo-renderhooks
```

To update all modules:

```
hugo mod get -u
```
