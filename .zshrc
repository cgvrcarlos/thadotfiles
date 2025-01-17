# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Enviroment Variables           
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

set -o vi

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

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Pompt
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
#           Completion
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

fpath+=~/.zfunc

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select


# Example to install completion:
# talosctl completion zsh > ~/.zfunc/_talosctl

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#           Sourcing
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

source <(fzf --zsh)
eval "$(pyenv init - zsh)"
