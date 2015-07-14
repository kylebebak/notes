# the completion scripts must exist in the same directory as this init script

if [ -n "$BASH_VERSION" ]; then
  root="$(dirname "${BASH_SOURCE[0]}")"
  source "$root/completions.bash"

elif [ -n "$ZSH_VERSION" ]; then
  root="$(dirname "$0")"
  source "$root/completions.zsh"
fi

