function setdir {
  _dir=$1

  while [[ ! -d "${_dir}" ]] || [[ ! "${_dir}" = /* ]]; do
    if [ -n "${_dir}" ]; then # don't display warning if _dir is empty string
      printf "\n${_bold}${_dir}${_normal} is not a valid notes directory\n"
    fi
    printf "Enter the ABSOLUTE PATH to your notes directory:\n"
    read -e _dir
  done

  printf "_ext=${_ext}\n_dir=\"${_dir}\"\n" > "$HOME/.notesrc"
  exit 0
}

function checknote {
  if [ ! -f "$1${_ext}" ]; then
    echo "the note ${_bold}$1${_normal} does not exist"
    exit 1
  fi
}

function checkdir {
  if [ ! -d "$1" ]; then
    echo "the directory ${_bold}$1${_normal} does not exist"
    exit 1
  fi
}

function checknoteordir {
  if [ ! -f "$1${_ext}" ] && [ ! -d "$1" ]; then
    echo "neither the note nor directory ${_bold}$1${_normal} exists"
    exit 1
  fi
}

# hash is faster than which
function checkexec {
  if hash $1 2>/dev/null; then
    :
  else
    echo "the executable ${_bold}$1${_normal} does not exist"
    exit 1
  fi
}

function checkname {
  if echo $1 | grep -E "[[:space:]]" >/dev/null; then
    echo "neither note nor directory names may contain whitespace characters"
    exit 1
  fi
}

# use find to recursively list notes in all subdirectories of specified directory
function previewnotes {

  TRAILINGSPACES=50
  INDENT="     "
  MAXCHARS=25
  DESCRIPTIONCHARS=50

  # ignore parent directory, ignore hidden files and directories, ignore files without proper extension
  find ${1} ! -path ${1} ! -path "*/\.*" \( -type f -name "*${_ext}" -or -type d \) 2>/dev/null \
  | while read x; do
    # remove leading ./ with cut, replace remaining path segments with indent spaces, then remove all non-space chars
    indent=`echo $x | cut -c 3- | sed -E "s:[^/]+/:$INDENT:g" | sed -E "s/[^ ]//g"`

    # get basename of note without extension, and trim excessively long names
    name=`basename "$x" | cut -d. -f1`
    name=${name:0:$MAXCHARS}

    numspaces=$[$TRAILINGSPACES - ${#name}]
    spaces=`head -c $numspaces < /dev/zero | tr '\0' ' '`

    if [ -f $x ]; then
      desc="`head -c $DESCRIPTIONCHARS $x | tr '\n' ' ' 2>/dev/null`..."
      echo -e "${indent}${_bold}${name}${_normal}${spaces}${desc}"

    elif [ -d $x ]; then
      desc="/"
      echo -e "${indent}${name}${spaces}${desc}"

    fi
  done

}

function opennote {
  if [ -z "$EDITOR" ]; then
    open $1
  else
    eval "$EDITOR $1"
  fi
}

function get_latest_release {
  curl --silent "https://api.github.com/repos/$1/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/' |
    sed -E 's/[[:space:]]//g'
}

function check_release {
  latest_release=`get_latest_release kylebebak/notes`
  if [ -z "$latest_release" ]; then
    return
  fi

  if [ $latest_release != $1 ]; then
    echo
    echo "latest release is ${latest_release}, and you have $1"
    echo "to upgrade, run \`brew upgrade notes\` if you're on OSX, else see here: https://github.com/kylebebak/notes"
  fi
}

# help
# --------------------------------------------------
unset usage
usage() {
  cat << EOF

${_bold}NAME${_normal}
    ${_bold}${name}${_normal}

${_bold}SYNOPSIS${_normal}
    ${_bold}${name}${_normal} [${_bold}-hmnNOpPrR${_normal}] note ...

${_bold}DESCRIPTION${_normal}
    [ ${_bold}-h${_normal} ]                                  get help (display this page)
    [ ${_bold}-v${_normal} ]                                  print version
    [ ${_bold}-c${_normal} ]                                  print notes config, and path to config file
    [ ${_bold}-d${_normal} DIR ]                              set notes directory (absolute path to existing directory)
    [ ${_bold}-f${_normal} PATTERN ]                          find notes: search for notes matching pattern (all matches)
    [ ${_bold}-F${_normal} PATTERN ]                          find notes: search for notes matching pattern (note names only)
    [ ${_bold}-m${_normal} NOTE NEW_NOTE ]                    move a note (change its name). can not be used to overwrite an existing note
    [ ${_bold}-n${_normal} NEW_NOTE ]                         create and open a note
    [ ${_bold}-N${_normal} NEW_DIR ]                          create a directory
    [ ${_bold}-O${_normal} ]                                  open notes directory
    [ ${_bold}-p${_normal} NOTE ]                             print contents of note
    [ ${_bold}-P${_normal} NOTE_OR_DIR ]                      print absolute path to note or directory
    [ ${_bold}-r${_normal} NOTE ]                             remove (delete) a note
    [ ${_bold}-R${_normal} DIR ]                              remove (delete) a directory

    All of these options are mutually exclusive, i.e. at most one option should be passed to ${_bold}${name}${_normal}.

    If ${_bold}${name}${_normal} is invoked without any options, the following modes of execution exist:

      - zero arguments        :                             list all notes
      - one argument          <note_or_dir>:                open this note, or list all notes under this directory
      - two arguments         <program> <note_or_dir>:      pass note or directory as argument to program
      - two arguments         <program> <glob_pattern>:     pass all matched notes as arguments to program, simply replace ${_bold}*${_normal} with ${_bold}${_glob}${_normal}
      - g.t. two arguments    <program> <notes>:            pass notes as arguments to program

${_bold}EXTENSIONS${_normal}
      Notes have a default extension of ${_bold}md${_normal}, which is assigned to the variable ${_bold}_ext${_normal} in ${_bold}$HOME/.notesrc${_normal}. Edit this variable to change the extension.
EOF
}
