notes
=====

**notes** is a command line tool that provides lightning-quick access, editing capability, and search functionality to persistent notes on your system. the default extension for notes is `.md`. this extension is totally absent from notes' syntax. **notes** supports **_tab completion_** and **_wildcard matching_** from any directory: the `*` wildcard is replaced by `@`


## features

* fast, natural syntax for manipulating notes **from any directory**

* quickly find notes using tab completion

* pass a note to any program, match notes using globbing patterns

* use any directory structure to organize notes

* create and keep track of hard links between base notes and their siblings



## installation

clone the repository and either add the root directory to your `$PATH`, or create a symlink in your `$PATH` that points to the **notes** executable in the root directory. use `chmod` to give yourself execution permission over **notes**

all notes will exist in the `_notes` subdirectory. this subdirectory contains an empty placeholder file called `.gitkeep`, which can be removed without affecting **notes**

in the `_completions` subdirectory is a script called `init.sh`. when run, this script loads the appropriate tab completions depending on the type of shell. to ensure that this script is run and that tab completions are enabled, insert the following into your shell startup file (e.g. `.bash_profile`)

`which notes >/dev/null && . "$( notes -i )"`

if you execute **notes** via symlink, *make sure that the name of the target file (the symlink) is also notes*. otherwise, tab completions won't work

#### extra

* the default extension for all notes is `.md`. markdown's formatting perks allow notes to be dynamic without sacrificing portability. the extension is set in the `ext` variable in the `notes` executable, and can be modified there

* clone notes into your dropbox to sync your notes and access them from all your devices


## usage

#### syntax
```
zero arguments          :                           list all notes
one argument            <note_or_dir>:              open this note, or list all notes under this directory
two arguments           <program> <note_or_dir>:    pass note or directory as argument to program
two arguments           <program> <glob_pattern>:   pass all matched notes as arguments to program, replace * with @
g.t. two arguments      <program> <notes>:          pass notes as arguments to program
```

#### options
```
[ -n NEW_NOTE ]                                     create and open a note
[ -N NEW_DIR ]                                      create a directory
[ -r NOTE ]                                         remove (delete) a note
[ -R DIR ]                                          remove (delete) a directory
[ -m NOTE NEW_NOTE ]                                move a note (change its name)
[ -f PATTERN ]                                      find notes: search for all notes matching pattern
[ -p NOTE ]                                         print contents of note
[ -P [NOTE_OR_DIR] ]                                print full path to note or directory
```

execute `notes -h` to get help and see more options


## license
This code is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).
