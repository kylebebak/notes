notes
=====

**notes** is a command line program that provides quick access, editing capability, and search functionality to all notes under a directory of your choosing. Under your notes directory, you can organize your notes into any folder structure you like.

The default extension for notes is `.md`. The extension is not part of notes' syntax. **notes** supports **_tab completion_** and **_wildcard matching_** from any directory: the `*` wildcard is replaced by `@`.


## Features
* Fast, natural syntax for manipulating notes **from any directory**
* Quickly find notes using tab completion
* Pass a note to any program, match notes using globbing patterns
* Use any directory structure to organize notes

![notes-tab-completion](https://raw.githubusercontent.com/kylebebak/notes/master/assets/notes_tab_completion.gif)


## Installation


#### OSX
```sh
brew tap kylebebak/tap
brew install notes

# upgrade
brew upgrade notes
```


#### Other systems
Clone this repo, or download and unzip the [tarball](https://github.com/kylebebak/notes/archive/1.1.0.tar.gz). Either add the `bin` directory to your `$PATH`, or create a symlink in your `$PATH` that points to the **notes** executable in the `bin` directory.

If you execute **notes** via symlink, *make sure that the name of the target file (the symlink) is also notes*. Otherwise, tab completions won't work.


#### Tab completion (bash and zsh)
To make **notes** truly sweet, insert the following into your shell startup file (e.g. `.bash_profile`):  
`which notes >/dev/null && . "$( notes -i )"`


#### Notes directory
The first time you run **notes**, you will be prompted to choose your notes directory. You need to use the **absolute path** to an existing directory. If you ever want to change it, run `notes -d <directory>`.


## Extra
The default extension for notes is `.md`, because markdown is great. If you want to change it, edit the `_ext` variable in `$HOME/.notesrc`.

If you want to print your current config, and the absolute path to the config file, execute `notes -c`.


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
[ -P NOTE_OR_DIR ]                                  print absolute path to note or directory
[ -d DIR ]                                          set notes directory (absolute path to existing directory)
```

Execute `notes -h` to get help and see more options, and `notes -v` to print the current version.


## License
This code is licensed under the [MIT License](https://opensource.org/licenses/MIT).
