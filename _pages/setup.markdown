---
layout: setup
title: Setup
script: tabs.js
sidebar:
  - name: "Prerequisites"
    href: "#prerequisites"
    sub:
      - name: "Terminal / Shell"
        href: "#terminal--shell"
      - name: "Python"
        href: "#python"
      - name: "Git"
        href: "#git"
      - name: "CMake"
        href: "#cmake"
      - name: "Downloading ughub"
        href: "#downloading-ughub"
      - name: "Installing ughub"
        href: "#installing-ughub"
  - name: "First Steps"
    href: "#first-steps"
    single: true
  - name: "Compilation of UG4"
    href: "#compilation-of-ug4"
    single: true
    sub:
      - name: Preparations
        href: "#preparations"
      - name: Setting up the build directory
        href: "#setting-up-the-build-directory"
      - name: Configuring your build
        href: "#configuring-your-build"
        single: true
---

This pages gives a broad overview on how to obtain and install **[ughub](https://github.com/UG4/ughub)** and how to use it to obtain **[UG4](https://github.com/UG4)**.<br>
It also provides a brief introduction on how to build UG4 on Linux, Mac-OSX and Windows. You can select the appropriate tab below to view the instructions for your operating system.

<nav>
  <div class="nav nav-tabs" id="nav-tab" role="tablist">
    <button class="nav-link active" type="button" id="linux-tab" data-bs-target=".linux" data-bs-toggle="tab" role="tab" aria-controls="linux" aria-selected="true" aria-expanded="true">Mac/Linux</button>
    <button class="nav-link" type="button" id="windows-tab" data-bs-target=".windows" data-bs-toggle="tab" role="tab" aria-controls="windows" aria-selected="false" aria-expanded="false">Windows</button>
  </div>
</nav>
<div class="tab-content" id="SetupTabA">
<div class="tab-pane fade show active linux" role="tabpanel" aria-labelledby="linux-tab" markdown="1">

{% include setup_linux.md %}

</div>
<div class="tab-pane fade windows" role="tabpanel" aria-labelledby="windows-tab" markdown="1">

{% include setup_windows.md %}

</div>
</div>

## First steps
ughub serves as a package management tool for the UG4 simulation framework. Use the following command to get some help on ughub's usage:

    ughub help

One typically starts by creating a directory into which all UG4 related packages shall be installed (again, the exact path is arbitrary):

    cd $HOME
    mkdir ug4

Now we can initialize this directory for usage with ughub:

    cd $HOME/ug4
    ughub init

This creates a local CMakeLists.txt file and creates a hidden folder `.ughub` in which package-sources are maintained. All further calls to ughub from within the directory tree located at $HOME/ug4 will now relate to this main directory.
To view a list of available packages, execute

    ughub list

or `ughub listpackages`. Which and how many packages are displayed depends on the registered package-sources. To view all registered sources execute

    ughub listsources

To install a package, simply execute `ughub install` with one or more of the available packages:

    ughub install Examples

Dependent packages will now be automatically installed.

In order to add new package-sources, ughub provides the command `addsource`. Theoretically, anybody can create new package-sources and host them e.g. on github. UG4's public package-source is hosted at

[https://github.com/UG4/ug4-packages](https://github.com/UG4/ug4-packages)

This is ughub's default source and always registered upon execution of `ughub init`. Feel free to clone it, to add your publicly available packages and to place a merge request.

## Compilation of UG4
For a more detailed introduction to ug4's build settings and to ug4 in general, please also refer to ug4's manual:

[http://ug4.github.io/docs](http://ug4.github.io/docs)

<div class="tab-content">
<div class="tab-pane fade show active linux" role="tabpanel" aria-labelledby="linux-tab" markdown="1">

### Preparations
In order to build UG4, you'll need a C++ compiler (e.g. g++ or clang) and cmake.

Before compiling UG4, please add the following line to your `$HOME/.bashrc` or `$HOME/.bash_profile` file:

    source $HOME/ug4/ugcore/scripts/shell/ugbash

and reload your .bashrc or .bash_profile files, e.g.:

    source $HOME/.bash_profile

This feature is not yet supported for Windows.

### Setting up the build directory
First create a build directory:

    cd $HOME/ug4
    mkdir build
    cd build

Then simply run cmake:

    cmake -DCMAKE_BUILD_TYPE=Release ..

</div>
<div class="tab-pane fade windows" role="tabpanel" aria-labelledby="windows-tab" markdown="1">

### Preparations

The Microsoft Visual C++ compiler is recommended for compilation of ug4 on Windows. It can be downloaded as part of the free "Express 2015 for Windows Desktop" edition of Visual Studio ([download here](https://www.visualstudio.com/downloads/#visual-studio-express-2015-for-windows-desktop)).

To allow for parallel compilation in the terminal one can optionally use the tool [jom](https://wiki.qt.io/Jom). Extract it and add the path in which the executable lies to your Path environment variable.

### Setting up the build directory
First create a build directory:

    cd $HOME/ug4
    mkdir build
    cd build

Make sure that you're running the `VS2015 x64 Command Prompt` (or similar).

In order to initialize your build please run

    cmake -G "NMake Makefiles JOM" -DCMAKE_BUILD_TYPE=Release -DSTATIC_BUILD=ON ..

or

    cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DSTATIC_BUILD=ON ..

depending on whether you installed JOM or not. Alternatively one could also generate Visual Studio Project files. However, this option is not discussed further in this introduction.

Note that static linking should be enabled by default on Windows. If you'd like to build a dynamic library, please have a look at ug4's documentation.

</div>
</div>

### Configuring your build
Each time you'll execute cmake on your ug4 folder, a list of installed plugins will be shown.
In order to activate an installed plugin, specify the cmake option `-DPLUGIN_NAME=ON`, e.g.:

    cmake -DConvectionDiffusion=ON .

You may also activate or deactivate all installed plugins at once:

    cmake -DENABLE_ALL_PLUGINS=ON .
    cmake -DDISABLE_ALL_PLUGINS=ON .

Some options speed up compilation considerably. E.g. if you only consider problems in two and three dimensional space and only need scalar matrix coefficients, you may use the following cmake options:

    cmake -DDIM="2;3" -DCPU=1 .

CMake only prepares the build-settings. To actually build UG4 you'll have to execute the build command.

<div class="tab-content">
<div class="tab-pane fade show active linux" role="tabpanel" aria-labelledby="linux-tab" markdown="1">

To start compiling execute

    make -j2

</div>
<div class="tab-pane fade windows" role="tabpanel" aria-labelledby="windows-tab" markdown="1">

To start compiling execute

    jom

or

    nmake

</div>
</div>

