![](header-card.png)

# DNB GoHugo Component / Publisher

❗this component is under development and things will change over time. [https://kollitsch.de/contact/](contact me for details) if you are interested or open an issue if you wish to have specific features added.

Draft: This component will add a publishing workflow to Hugo content (think of author > editor > publisher, realised via Git usernames/rights and signatures) and extends status of the content (like draft, edited, published, recalled, etc.). It will give overviews of content pieces with filters by state/type/etc.

It will NOT add a secure authentication method and access limitation per content type. That is not possible with the given tools. But we can regulate user groups (author, editor, etc.) via email/name layouts of git commits and a strict githook setup.

It's an experimental system.

## Authorship

There are many ways to demark authorship in GoHugo.



### Denote authorship

Publisher accepts several methods to denote authorship. The component will look for author information in the following order:

- [Multiple authors of a content piece via frontmatter](#multiple-authors-of-a-content-piece-via-frontmatter)
- [Single author of a content piece via frontmatter](#single-author-of-a-content-piece-via-frontmatter)
- [Single author of the whole site via configuration](#single-author-of-the-whole-site-via-configuration)
- [Multiple authors of the whole site via configuration](#multiple-authors-of-the-whole-site-via-configuration)
- [Single or multiple authors via data-configuration](#single-or-multiple-authors-via-data-configuration)

#### Multiple authors of a content piece via frontmatter

```toml
[[authors]]
name = "Patrick Kollitsch"
[[authors]]
name = "Jane Doe"
```

#### Single author of a content piece via frontmatter

```toml
[author]
name = "Patrick Kollitsch"
```

```toml
[author]
[author.john_doe]
name = "John Doe"
location = "San Francisco"
[author.jane_smith]
name = "Jane Smith"
location = "New York"
```

#### Single author of the whole site via configuration

```toml
```

#### Multiple authors of the whole site via configuration

```toml
```

#### Single or multiple authors via data-configuration

```toml
```
