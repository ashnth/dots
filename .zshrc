# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

# Environment Variables
export EDITOR="nvim"
export VISUAL="nvim"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=fg:#ebdbb2,bg:#282828,hl:#b16286 
  --color=fg+:#689d6a,bg+:#32302f,hl+:#d3869b 
  --color=info:#d65d0e,prompt:#458588,pointer:#fe8019 
  --color=marker:#8ec07c,spinner:#cc241d,header:#fabd2f
"

export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH
# Options
setopt autocd
setopt globdots
setopt extended_history
setopt appendhistory
setopt inc_append_history
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias ..='cd ..'
alias c='clear'
alias v='nvim'
alias ls='eza --color=always -a --icons=always'
alias anime='fastanime anilist'
alias docker='podman'

# Functions
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Theme
source ~/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completion
fpath=(~/.zsh_plugins/zsh-completions/src $fpath)
autoload -U compinit && compinit

# Fzf Tab
source ~/.zsh_plugins/fzf-tab/fzf-tab.plugin.zsh

# Auto Suggestions
source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Completion styling
zstyle ':completion:*' rehash true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --all --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:*' fzf-min-height 100
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# Shell intergrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(dircolors -b)"

# Syntax highlighting - Needs to be at end
source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
