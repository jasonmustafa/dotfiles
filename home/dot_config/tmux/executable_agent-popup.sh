#!/usr/bin/env bash
# Agent popup manager - single _agent session with windows named after "parent" sessions
# Each parent session gets its own window that persists between popup toggles

parent="$PARENT"
dir="$DIR"

if ! tmux has -t _agent 2>/dev/null; then
	# Create agent session with first window named after parent
	tmux new-session -d -s _agent -n "$parent" -c "$dir" claude
	tmux set-option -t _agent status-right ""
elif ! tmux list-windows -t _agent -F '#W' | grep -qxF "$parent"; then
	# Create new window for this parent session
	tmux new-window -t _agent -n "$parent" -c "$dir" claude
fi

exec tmux attach -t "_agent:$parent"
