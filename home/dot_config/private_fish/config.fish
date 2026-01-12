### PATH

set -e fish_user_paths
set -U fish_user_paths $HOME/bin $HOME/.local/bin

### EXPORT

set EDITOR "nvim"
set VISUAL "nvim"
set -x MANPAGER "nvim +Man!"
set -x SSH_AUTH_SOCK "$HOME/.1password/agent.sock"

# fzf Catppuccin Mocha theme
set FZF_DEFAULT_OPTS "\
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"

# fzf
fzf --fish | source

# zoxide
zoxide init fish | source
