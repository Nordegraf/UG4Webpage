This is supposed to serve as a short guide to add pages to the website

## Adding pages
Adding a page is as simple as adding a html or markdown file to the `_pages` directory. Jekyll will convert markdown automatically to html. The page will be published under the same name as the file including the subdirectories.

For example: A file located in `_pages/tutorials/scripting` will be published under `ug4.github.io/tutorials/scripting`.

A page must contain a so called front matter header including a layout and a title. There are two basic layout available. The default and the title layout. The latter one is simply the default layout, but the title attribute of the front matter is added before the content following in the file. The most basic front matter needed in EVERY file, that is supposed to be a page is:

```
---
layout: default
title: Pagetitle
---
```

## Add pages to the navigation bar
To add a page to the navigation bar simply edit the `_data/navigation.yml`. Entries are a YAML list and each element need a name and a link attribute. The link should be a relative (!) url to a page. E.g. for the setup page it should be:
```
- name: Setup
  link: /setup
```

Dropdown Menu entries are organized in a similar fashion, by adding a YAML conform list of the same layout under a `dropdown` attribute. Dropdown Menus can not contain another dropdown menu.

```
- name: Tutorials
  sublink: /tutorials/
  dropdown:
  - name: Lua Scripting
    link: /tutorials/scripting
```

## Adding Titlepage images
Titlepage images are added through the banner.yml file located in the _data directory.
Image files should be located in the `assets/img/banner/` directory. Each image needs an alt and a description attribute.

## Adding publications
To add publications to the Publications page, edit the publications.bib file and add a bibtex entry.
