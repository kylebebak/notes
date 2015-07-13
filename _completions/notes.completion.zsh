_notes_complete() {
  local note completions
  note="$1"
  # list of completions generated in notes executable, as opposed to within this script, which would require an additional cd operation
  completions="$(notes -C)"
  reply=( "${(ps:\n:)completions}" )
}

compctl -K _notes_complete notes
# including -f flag would also match files in current directory
