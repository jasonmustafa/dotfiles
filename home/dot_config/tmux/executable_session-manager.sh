#!/usr/bin/env bash

set -u

if ! command -v fzf > /dev/null 2>&1; then
  tmux display-message "session-manager: fzf not found"
  exit 1
fi

while true; do
  current_session="$(tmux display-message -p '#S')"
  mapfile -t result < <(
    {
      tmux list-sessions -F '#{session_name}' | grep -vxF "$current_session"
      printf '%s\n' "$current_session"
    } |
      fzf \
        --reverse \
        --header='enter: switch session | Ctrl-N: new session | Esc: close' \
        --prompt='session> ' \
        --expect=ctrl-n
  )

  key="${result[0]:-}"
  selected="${result[1]:-}"

  if [[ "$key" == "ctrl-n" ]]; then
    printf "session name: "
    IFS= read -r name || exit 0

    if [[ -z "${name}" ]]; then
      continue
    fi

    if tmux has-session -t "$name" 2> /dev/null; then
      tmux switch-client -t "$name"
      exit 0
    fi

    if tmux new-session -d -s "$name" 2> /dev/null; then
      tmux switch-client -t "$name"
      exit 0
    fi

    tmux display-message "session-manager: could not create session '$name'"
    sleep 1
    continue
  fi

  if [[ -z "$selected" ]]; then
    exit 0
  fi

  tmux switch-client -t "$selected"
  exit 0
done
