#!/usr/bin/env bash
# Claude Code status line with git awareness and Catppuccin Mocha colors

input=$(cat)

# Catppuccin Mocha colors (24-bit true color)
RESET='\033[0m'
TEAL='\033[38;2;148;226;213m'      # #94e2d5
LAVENDER='\033[38;2;180;190;254m'  # #b4befe
MAUVE='\033[38;2;203;166;247m'     # #cba6f7
PINK='\033[38;2;245;194;231m'      # #f5c2e7

# Extract values from JSON
MODEL=$(echo "$input" | jq -r '.model.display_name')
CWD=$(echo "$input" | jq -r '.workspace.current_dir')
REMAINING=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Shorten home directory to ~
CWD_DISPLAY="${CWD/#$HOME/~}"

# Git information
GIT_INFO=""
if git -C "$CWD" rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git -C "$CWD" branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        # Check for uncommitted changes
        if git -C "$CWD" diff --quiet 2>/dev/null && git -C "$CWD" diff --cached --quiet 2>/dev/null; then
            GIT_INFO="  ${MAUVE}\uf418 ${BRANCH}${RESET}"
        else
            GIT_INFO="  ${MAUVE}\uf418 ${BRANCH}*${RESET}"
        fi
    fi
fi

# Context remaining
CTX=""
if [ -n "$REMAINING" ]; then
    REMAINING_INT=${REMAINING%.*}
    CTX="  ${PINK}\uf0e4 ${REMAINING_INT}%${RESET}"
fi

# Build status line
# f4f5 = claude icon, f07b = folder, f418 = git branch, f0e4 = gauge
echo -e "${TEAL}\uf4f5 ${MODEL}${RESET}  ${LAVENDER}\uf07b ${CWD_DISPLAY}${RESET}${GIT_INFO}${CTX}"
