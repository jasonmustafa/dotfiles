#!/usr/bin/env bash
# session-module.sh — tmux session pill with mode-aware icon/color
# Usage: #(~/.config/tmux/session-module.sh #{client_prefix} #{pane_mode} #{pane_in_mode} #S)
#
# Args (expanded by tmux before shell invocation):
#   $1 - client_prefix  (1 or 0)
#   $2 - pane_mode      (tree-mode, clock-mode, copy-mode, etc.)
#   $3 - pane_in_mode   (1 or 0/empty)
#   $4 - session name

# Rosé Pine
LOVE='#eb6f92'
FOAM='#9ccfd8'
IRIS='#c4a7e7'
ROSE='#ebbcba'
PINE='#31748f'
BASE='#191724'      # fg on accent backgrounds

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
    COLOR=$LOVE ICON=$I_PREFIX
elif [[ $2 == tree-mode ]]; then
    COLOR=$FOAM ICON=$I_TREE
elif [[ $2 == clock-mode ]]; then
    COLOR=$IRIS ICON=$I_CLOCK
elif [[ $3 != 0 && -n $3 ]]; then
    COLOR=$ROSE ICON=$I_COPY
else
    COLOR=$FOAM ICON=$I_TMUX
fi

# Build pill: ◖ icon session ◗
printf '#[fg=%s]%s#[fg=%s,bg=%s,bold] %s %s #[nobold,fg=%s,bg=default]%s' \
    "$COLOR" "$L" "$BASE" "$COLOR" "$ICON" "$4" "$COLOR" "$R"
