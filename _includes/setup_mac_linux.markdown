
# Installation

<section id="prerequisites">

## Prerequisites

### Terminal / Shell
**Mac-OSX** and **Linux** (**Unix**) users should be able to use their default terminal application to execute the commands below.

### Python
ughub requires _**Python**_ to run (at least version 2.6 should be available, higher is recommended). Please make sure that python is installed by executing the following command:

    python --version

If it is not yet installed, please do one of the following:

As a Linux user, use your package manager to install it, e.g.:

    sudo apt-get install python

Mac users can download an installer from <https://www.python.org/downloads/release> (e.g. Python 2.7 or the latest Python 3 installer)

### Git
Please also make sure that _**git**_ is installed on your system and that it can be invoked from your terminal or shell.

### CMake
You will need _**cmake_** to generate the build files for your compiler. On Unix systems you may install cmake using your package manager:

    sudo apt-get install cmake

For OSX you may download an installer at <https://cmake.org/>.

</section>

## Downloading ughub
Please clone the github repository, e.g. by executing the following commands:

    cd $HOME
    git clone https://github.com/UG4/ughub

This will download ughub to _$HOME/ughub_. You may of course clone the repository to any other location. Simply replace _$HOME/ughub_ with your path for the remainder of this introduction.

Please make sure to update your ughub installation from time to time by executing

    cd $HOME/ughub
    git pull


## Installing ughub
ughub should run out of the box. However, in order to execute it from any path, you should either edit your PATH environment variable by adding the following line to your $HOME/.bash_profile or $HOME/.bashrc file

    export PATH=$PATH:$HOME/ughub

or create a link to $HOME/ughub/ughub from within a path which is already contained in your PATH variable, e.g., like this

    cd $HOME/bin
    ln -s $HOME/ughub/ughub ughub

If you choose to edit your PATH variable, please make sure to reload your .bash_profile or .bashrc files, e.g.:

    source $HOME/.bash_profile

If you are interested in using auto-completion (in bash) while using ughub, add the following additional line to your $HOME/.bash_profile or $HOME/.bashrc file

    source $HOME/ughub/autocompletions/ughub-completion.bash

and reload the file. Alternatively, you can place this line in '\~/.bash_completion'.
To use this in zsh, you need to use bashcompinit, see [here](https://stackoverflow.com/a/8492043).
Autocomplete is also available for fish. To use this, copy 'autocompletions/ughub-completion.fish' to '\~/.config/fish/completions/ughub.fish' (and reload your fish instance).

### Unix
In order to build UG4, you'll need a C++ compiler (e.g. g++ or clang) and cmake.

### Windows
The Microsoft Visual C++ compiler is recommended for compilation of ug4 on windows. It can be downloaded as part of the free "Express 2015 for Windows Desktop" edition of Visual Studio ([download here](https://www.visualstudio.com/downloads/#visual-studio-express-2015-for-windows-desktop)).

To allow for parallel compilation in the terminal one can optionally use the tool [jom](https://wiki.qt.io/Jom). Extract it and add the path in which the executable lies to your Path environment variable.

## Preparations (Unix)
Before compiling UG4 on Unix, please add the following line to your $HOME/.bashrc or $HOME/.bash_profile file:

    source $HOME/ug4/ugcore/scripts/shell/ugbash

and reload your .bashrc or .bash_profile files, e.g.:

    source $HOME/.bash_profile

This feature is not yet supported for Windows.

## Setting up the build directory
First create a build directory:

    cd $HOME/ug4
    mkdir build
    cd build

On **Unix** simply run cmake:

    cmake -DCMAKE_BUILD_TYPE=Release ..

On **Windows** make sure that you're running the *VS2015 x64 Command Prompt* (or similar).

In order to initialize your build please run

     cmake -G "NMake Makefiles JOM" -DCMAKE_BUILD_TYPE=Release -DSTATIC_BUILD=ON ..
or

    cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DSTATIC_BUILD=ON ..

depending on whether you installed JOM or not. Alternatively one could also generate Visual Studio Project files. However, this option is not discussed further in this introduction.

Note that static linking should be enabled by default on Windows. If you'd like to build a dynamic library, please have a look at ug4's documentation.

## Configuring your build
Each time you'll execute cmake on your ug4 folder, a list of installed plugins will be shown.
In order to activate an installed plugin, specify the cmake option -DPLUGIN_NAME=ON, e.g.:

    cmake -DConvectionDiffusion=ON .

You may also activate or deactivate all installed plugins at once:

    cmake -DENABLE_ALL_PLUGINS=ON .
    cmake -DDISABLE_ALL_PLUGINS=ON .

Some options speed up compilation considerably. E.g. if you only consider problems in two and three dimensional space and only need scalar matrix coefficients, you may use the following cmake options:

    cmake -DDIM="2;3" -DCPU=1 .

CMake only prepares the build-settings. To actually build UG4 you'll have to execute the build command.

On **Unix** execute, e.g.:

    make -j2

On **Windows** execute, e.g.:

    jom

or

    nmake

depending on which type of generator you used in your first call to cmake.

