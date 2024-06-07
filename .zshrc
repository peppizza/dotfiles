# Set the zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if not exists
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit load atuinsh/atuin

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::cp

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Up arrow: ^[[A, Down arrow: ^[[B, CTRL + Left arrow: ^[[1;5D, CTRL + Right arrow: ^[[1;5C
# Keybindings
bindkey -e
bindkey "^[[A" history-search-backward
bindkey "^p" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^n" history-search-forward
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":completion:*:git-checkout:*" sort false
zstyle ":completion:*:descriptions" format "[%d]"
zstyle ":fzf-tab:complete:cd:*" fzf-preview "eza -1 --color=always $realpath"
zstyle ":fzf-tab:*" switch-groups "<" ">"
zstyle ":fzf-tab:*" fzf-command ftb-tmux-popup
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "eza -1 --color=always $realpath"

# Aliases
alias ls="eza"
alias c="clear"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
