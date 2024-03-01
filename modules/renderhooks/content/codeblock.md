---
'$schema': /static/_schemata/blog.schema.yaml
type: blog
title: Code Highlighting
linkTitle: Code Highlighting
description: ""
summary: ""

draft: true

date: "2024-02-28T10:46:27+07:00"
publishDate: "2024-02-28T10:46:27+07:00"
lastmod: "2024-02-28T10:46:27+07:00"

resources:
  - title: Photo by [Name](Link) via [Unsplash](https://unsplash.com/)
    name: image name if other than src
    src: ave-calvar-HcUDHJfd5GY-unsplash.jpg

author:
  name: Patrick Kollitsch
  homepage: https://kollitsch.dev/
  image: /images/patrick-kollitsch.jpg

authors:
  - name: Patrick Kollitsch
    homepage: https://kollitsch.dev/
    image: /images/patrick-kollitsch.jpg

categories:
  - category1

tags:
  - tag1
  - tag2
  - tag3
  - 100DaysToOffload

keywords:
  - keyword1
  - keyword2
  - keyword3
---

## Sample 1

```toml
[markup.highlight]
  codeFences = true
  guessSyntax = true
  hl_Lines = ""
  lineNoStart = 1
  lineNos = true
  lineNumbersInTable = true
  noClasses = false
  style = "monokai"
  tabWidth = 4
```

## Sample 2

```toml {linenos=[1,"5-6"],something=else,filename="sample.toml"}
[markup.highlight]
  codeFences = true
  guessSyntax = true
  hl_Lines = ""
  lineNoStart = 1
  lineNos = true
  lineNumbersInTable = true
  noClasses = false
  style = "monokai"
  tabWidth = 4
```
