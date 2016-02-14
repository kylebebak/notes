notes
=====

**notes** is a command line program that provides quick access, editing capability, and search functionality to all notes under a directory of your choosing. Under your notes directory, you can organize your notes into any folder structure you like.

The default extension for notes is `md`. the extension is not part of notes' syntax. **notes** supports **_tab completion_** and **_wildcard matching_** from any directory: the `*` wildcard is replaced by `@`.


## Features

* Fast, natural syntax for manipulating notes **from any directory**
* Quickly find notes using tab completion
* Pass a note to any program, match notes using globbing patterns
* Use any directory structure to organize notes


## Installation

#### on OSX
```sh
brew tap kylebebak/notes
brew install notes
```

#### Tab completion (bash and zsh)
Insert the following into your shell startup file (e.g. `.bash_profile`).  
`which notes >/dev/null && . "$( notes -i )"`

#### Notes directory
The first time you run **notes**, you will be prompted to choose your notes directory. If you ever want to change this directory, run `notes -d`.

#### Other systems
Clone this repo and either add the root directory to your `$PATH`, or create a symlink in your `$PATH` that points to the **notes** executable in the root directory. Use `chmod` to give yourself execution permission over **notes**.

If you execute **notes** via symlink, *make sure that the name of the target file (the symlink) is also notes*. Otherwise, tab completion won't work.


## Extra

* The default extension for notes is `md`, because markdown is great. If you want to change it, edit the `_ext` variable in `_config/env.sh`.


## Usage

#### Syntax
```
zero arguments          :                           list all notes
one argument            <note_or_dir>:              open this note, or list all notes under this directory
two arguments           <program> <note_or_dir>:    pass note or directory as argument to program
two arguments           <program> <glob_pattern>:   pass all matched notes as arguments to program, replace * with @
g.t. two arguments      <program> <notes>:          pass notes as arguments to program
```

#### Options
```
[ -n NEW_NOTE ]                                     create and open a note
[ -N NEW_DIR ]                                      create a directory
[ -r NOTE ]                                         remove (delete) a note
[ -R DIR ]                                          remove (delete) a directory
[ -m NOTE NEW_NOTE ]                                move a note (change its name)
[ -f PATTERN ]                                      find notes: search for all notes matching pattern
[ -p NOTE ]                                         print contents of note
[ -P NOTE_OR_DIR ]                                  print full path to note or directory
[ -d ]                                              open prompt to reset notes directory                                  
```

Execute `notes -h` to get help and see more options.


## License
This code is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).
