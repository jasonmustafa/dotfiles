#!/usr/bin/env bash
# Agent popup manager - single _agent session with parent:suffix window naming
# Multiple instances per project: dotfiles:button, dotfiles:deps, etc.

parent="$PARENT"
dir="$DIR"
suffix="${SUFFIX:-$(date +%H%M%S)}"

# Window name: parent:suffix (e.g., dotfiles:button)
win_name="$parent:$suffix"

if ! tmux has -t _agent 2>/dev/null; then
	tmux new-session -d -s _agent -n "$win_name" -c "$dir" claude
	tmux set-option -t _agent status-right ""
elif ! tmux list-windows -t _agent -F '#W' | grep -qxF "$win_name"; then
	# Find last window with same parent, insert after it to keep grouped
	last_idx=$(tmux list-windows -t _agent -F '#I #W' | \
		grep " $parent:" | tail -1 | cut -d' ' -f1)
	if [[ -n "$last_idx" ]]; then
		tmux new-window -a -t "_agent:$last_idx" -n "$win_name" -c "$dir" claude
	else
		tmux new-window -t _agent -n "$win_name" -c "$dir" claude
	fi
fi

exec tmux attach -t "_agent:$win_name"
