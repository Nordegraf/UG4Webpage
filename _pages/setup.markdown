---
layout: title
title: Setup
script: tabs.js
---

# ughub

*ughub* allows to easily install all the different plugins and applications that
are built on top of [UG4](https://github.com/UG4). It automatically handles inter-package dependencies
and helps in managing the different involved git repositories.

# Contents
This document should give a broad overview on how to obtain and install **ughub** and how to use it to obtain **UG4**.
It also provides a brief introduction on how to build UG4.

* [Installation](#installation)
* [First Steps](#first-steps)
* [Compilation of UG4](#compilation-of-ug4)


<a href="#prerequisites">Prerequisites</a>

<nav>
  <div class="nav nav-tabs" id="nav-tab" role="tablist">
    <button class="nav-link" id="linux-tab" data-bs-target=".first" data-bs-toggle="tab" role="tab" aria-controls="first" aria-selected="false">Mac/Linux</button>
    <button class="nav-link active" id="windows-tab" data-bs-target=".second" data-bs-toggle="tab" role="tab" aria-controls="second" aria-selected="true">Windows</button>
  </div>
</nav>
<div class="tab-content" id="SetupTabA">
  <div class="tab-pane fade first" id="panel_a_first" role="tabpanel" aria-labelledby="linux-tab">
  {% capture linux %} {% include setup_mac_linux.markdown %} {% endcapture %}
  {{ linux | markdownify }}
  </div>
  <div class="tab-pane fade show active second" id="panel_a_second" role="tabpanel" aria-labelledby="windows-tab">
  {% capture windows %} {% include setup_windows.markdown %} {% endcapture %}
  {{ windows | markdownify }}
  </div>
</div>

# First steps
ughub serves as a package management tool for the UG4 simulation framework. Use the following command to get some help on ughub's usage:

    ughub help

One typically starts by creating a directory into which all UG4 related packages shall be installed (again, the exact path is arbitrary):

    cd $HOME
    mkdir ug4

Now we can initialize this directory for usage with ughub:

    cd $HOME/ug4
    ughub init

This creates a local CMakeLists.txt file and creates a hidden folder '.ughub' in which package-sources are maintained. All further calls to ughub from within the directory tree located at $HOME/ug4 will now relate to this main directory.
To view a list of available packages, execute

    ughub list

or 'ughub listpackages'. Which and how many packages are displayed depends on the registered package-sources. To view all registered sources execute

    ughub listsources

To install a package, simply execute 'ughub install' with one or more of the available packages:

    ughub install Examples

Dependent packages will now be automatically installed.

In order to add new package-sources, ughub provides the command 'addsource'. Theoretically, anybody can create new package-sources and host them e.g. on github. UG4's public package-source is hosted at

https://github.com/UG4/ug4-packages

This is ughub's default source and always registered upon execution of 'ughub init'. Feel free to clone it, to add your publicly available packages and to place a merge request.

# Compilation of UG4
For a more detailed introduction to ug4's build settings and to ug4 in general, please also refer to ug4's manual:

http://ug4.github.io/docs

## Prerequisites

<div class="tab-content" id="SetupTabB">
  <div class="tab-pane fade first" id="panel_b_first" role="tabpanel" aria-labelledby="linux-tab">
  B First
  </div>
  <div class="tab-pane fade show active second" id="panel_b_second" role="tabpanel" aria-labelledby="windows-tab">
  B Second
  </div>
</div>
