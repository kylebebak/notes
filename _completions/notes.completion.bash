_notes_complete() {
  COMPREPLY=()
  local note="${COMP_WORDS[COMP_CWORD]}"
  # list of completions generated in notes executable, as opposed to within this script, which would require an additional cd operation
  local completions="$(notes -C)"
  COMPREPLY=( $(compgen -W "$completions" -- "$note") )
}

complete -F _notes_complete notes
# including -f flag would also match files in current directory
