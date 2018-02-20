# Path to your oh-my-zsh configuration.
#ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

zstyle :omz:plugins:ssh-agent agent-forwarding on
# zstyle ':completion:::::' completer _complete _approximate
# zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# zstyle ':completion:*' matcher-list '' \
#   'm:{a-z\-}={A-Z\_}' \
#   'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
#   'r:|?=** m:{a-z\-}={A-Z\_}'

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false

export NVM_LAZY_LOAD=true

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT=true

source ~/.zgen/zgen.zsh

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/battery
    zgen oh-my-zsh plugins/colored-man-pages
    zgen oh-my-zsh plugins/encode64
    # zgen oh-my-zsh plugins/fabric
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-extras
    zgen oh-my-zsh plugins/github
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/httpie
    zgen oh-my-zsh plugins/jump
    zgen oh-my-zsh plugins/kubectl
    zgen oh-my-zsh plugins/mercurial
    zgen oh-my-zsh plugins/mosh
    zgen oh-my-zsh plugins/pass
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/ssh-agent
    zgen oh-my-zsh plugins/gpg-agent
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/systemd
    zgen oh-my-zsh plugins/taskwarrior
    zgen oh-my-zsh plugins/tmux
    # zgen oh-my-zsh plugins/vagrant
    zgen oh-my-zsh plugins/vim-interaction
    zgen oh-my-zsh plugins/virtualenv
    # zgen oh-my-zsh plugins/virtualenvwrapper
    # zgen oh-my-zsh plugins/fasd

    zgen load willghatch/zsh-cdr
    zgen load djui/alias-tips
    zgen load nojhan/liquidprompt
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zaw
    zgen load termoshtt/zaw-systemd
    zgen load lukechilds/zsh-nvm
    zgen load mrkmg/borgbackup-zsh-completion
    zgen load Vifon/deer
    zgen load greymd/tmux-xpanes

    # save all to init script
    zgen save
fi

# User configuration

export PATH=$HOME/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/.gem/ruby/2.2.0/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

if [ -e /usr/share/fzf/completion.zsh ]; then
    source /usr/share/fzf/completion.zsh
    # export FZF_COMPLETION_TRIGGER=''
    # bindkey '^T' fzf-completion
    # bindkey '^I' $fzf_default_completion
fi

autoload -U compinit; compinit
setopt GLOB_COMPLETE

autoload zmv
alias zmv='noglob zmv'

autoload -U edit-command-line
zle -N edit-command-line
bindkey ‘^xe’ edit-command-line
bindkey ‘^x^e’ edit-command-line

# deer
autoload -U deer
zle -N deer
bindkey '\ek' deer

# zaw
bindkey '^r' zaw-history
zstyle ':filter-select' extended-search yes
zstyle ':filter-select' hist-find-no-dups yes
zstyle ':filter-select' case-insensitive yes

export EDITOR="vim"
export LESS="-RFX"
export PKGEXT=".pkg.tar"

source /usr/bin/virtualenvwrapper_lazy.sh

# OPAM configuration
. /home/laeroth/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

alias psyu="pacaur -Syu"
alias ranger="LESS=-R TERMCMD=urxvt ranger"
alias vvim="vim --servername GVIM"

gbp() {
    local issue="$1" refspec="$2" branch="$3"
    git fetch origin "${branch}:${branch}" && git checkout -b "backport/${issue}/${branch}" "${branch}" && git cherry-pick -e "${refspec}"
}

gbp-pr() {
    local issue="$1" branch="$2"
    hub compare "${branch}...weltenwort:backport/${issue}/${branch}"
}

gbp-all() {
    local issue="$1" refspec="$2" branch="$3"
    gbp "${issue}" "${refspec}" "${branch}" && gp weltenwort && gbp-pr "${issue}" "${branch}"
}
