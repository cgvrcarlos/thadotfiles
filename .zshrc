# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Enviroment Variables           
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

export VISUAL=nvim
export EDITOR=nvim
export TERM="tmux-256color"

# +-+- Directories -+-+

export GITUSER="cgvrcarlos"
export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"

# +-+- Pyenv -+-+

export PYENV_ROOT="$HOME/.pyenv"

# +-+- FNM -+-+

export FNM_PATH="$HOME/.local/share/fnm"

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Path Configuration
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

setopt extended_glob null_glob

path=(
	$path
	$HOME/bin
	$HOME/.local/bin
	$SCRIPTS
	$PYENV_ROOT/bin
  $FNM_PATH
)

typeset -U path

path=($^path(N-/))

export PATH

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           History
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
HISTDUP=erase


setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions


# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Prompt
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

if [[ "$OSTYPE" == darwin* ]]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
else
  fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit

prompt pure

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Aliases
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

alias v=nvim

alias c="clear"

alias t="tmux"
alias e="exit"

alias ls="ls --color=auto"
alias la="ls -lathr"

alias syu="yay -Syu"

# Navigation
alias scripts="cd $SCRIPTS"

# Navigation Repos
alias repos="cd $REPOS"
alias ghrepos="cd $GHREPOS"
alias dot="cd $GHREPOS/dotfiles"

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Plugins
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Completion
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

fpath+=~/.zfunc

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -U compinit && compinit

zinit cdreplay -q

# Example to install completion:
# talosctl completion zsh > ~/.zfunc/_talosctl

# Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Sourcing
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

# Fuzzy finder
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# Python version manager
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init - zsh)"
fi

# Node version manager
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Start tmux session if not already in one
if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
