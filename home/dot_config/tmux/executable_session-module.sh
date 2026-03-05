#!/usr/bin/env bash
# session-module.sh — tmux session pill with mode-aware icon/color
# Usage: #(~/.config/tmux/session-module.sh #{client_prefix} #{pane_mode} #{pane_in_mode} #S)
#
# Args (expanded by tmux before shell invocation):
#   $1 - client_prefix  (1 or 0)
#   $2 - pane_mode      (tree-mode, clock-mode, copy-mode, etc.)
#   $3 - pane_in_mode   (1 or 0/empty)
#   $4 - session name

# Catppuccin Mocha
RED='#f38ba8'
TEAL='#94e2d5'
MAUVE='#cba6f7'
BLUE='#89b4fa'
SURFACE1='#45475a'   # pill background

# Nerd Font icons (trailing space for padding)
I_TMUX=$'\uebc8 '    # ebc8  tmux
I_PREFIX=$'\uf427 '  # f427  rocket
I_COPY=$'\uf4bb '    # f4bb  copy
I_TREE=$'\uf03a '    # f03a  list
I_CLOCK=$'\uf43a '   # f43a  clock

# Powerline round separators
L=$'\ue0b6'  # left half circle
R=$'\ue0b4'  # right half circle

# Mode detection (priority: prefix > tree > clock > copy > normal)
if [[ $1 == 1 ]]; then
    COLOR=$RED ICON=$I_PREFIX
elif [[ $2 == tree-mode ]]; then
    COLOR=$TEAL ICON=$I_TREE
elif [[ $2 == clock-mode ]]; then
    COLOR=$MAUVE ICON=$I_CLOCK
elif [[ $3 != 0 && -n $3 ]]; then
    COLOR=$BLUE ICON=$I_COPY
else
    COLOR=$TEAL ICON=$I_TMUX
fi

# Build pill: ◖ icon session ◗
printf '#[fg=%s]%s#[fg=%s,bg=%s,bold] %s%s #[nobold,fg=%s,bg=default]%s' \
    "$SURFACE1" "$L" "$COLOR" "$SURFACE1" "$ICON" "$4" "$SURFACE1" "$R"
