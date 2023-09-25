### Prerequisites

#### Terminal / Shell

You should be able to use your default terminal application to execute the commands below.

#### Python

ughub requires _**Python**_ to run (at least version 2.6 should be available, higher is recommended). Please make sure that Python is installed by executing the following command:

    python --version

If it is not installed yet, please install it through your package manager if your on Linux. On Mac-OSX, you can download and install it from

[https://www.python.org/downloads/](https://www.python.org/downloads/)

#### Git

Please also make sure that git is installed on your system and that it can be invoked from your terminal or shell.

#### CMake

You will need _**cmake**_ to generate the build files for your compiler. You may install with your package manager on Linux or from

[https://cmake.org](https://cmake.org)

### Downloading ughub
Please clone the GitHub repository, e.g. by executing the following commands:

    cd $HOME
    git clone https://github.com/UG4/ughub

This will download ughub to `$HOME/ughub`. You may of course clone the repository to any other location. Simply replace `$HOME/ughub` with your path for the remainder of this introduction.

Please make sure to update your ughub installation from time to time by executing

    cd $HOME/ughub
    git pull

### Installing ughub
ughub should run out of the box. However, in order to execute it from any path, you should either edit your PATH environment variable by adding the following line to your `$HOME/.bash_profile` or `$HOME/.bashrc` file

    export PATH=$PATH:$HOME/ughub

or create a link to `$HOME/ughub/ughub` from within a path which is already contained in your PATH variable, e.g., like this

    cd $HOME/bin
    ln -s $HOME/ughub/ughub ughub

If you choose to edit your PATH variable, please make sure to reload your `.bash_profile` or `.bashrc` files, e.g.:

    source $HOME/.bash_profile

If you are interested in using auto-completion (in bash) while using ughub, add the following additional line to your `$HOME/.bash_profile` or `$HOME/.bashrc` file

    source $HOME/ughub/autocompletions/ughub-completion.bash

and reload the file. Alternatively, you can place this line in `~/.bash_completion`.
To use this in zsh, you need to use bashcompinit, see [here](https://stackoverflow.com/a/8492043).
Autocomplete is also available for fish. To use this, copy `autocompletions/ughub-completion.fish` to `~/.config/fish/completions/ughub.fish` (and reload your fish instance).
