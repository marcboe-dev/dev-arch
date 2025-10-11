# ==============================================================
# >>> Bash basics >>>
# Standard interactive shell setup
# ==============================================================

# If not running interactively, don’t do anything
case $- in
*i*) ;;
*) return ;;
esac

# History configuration
HISTCONTROL=ignoreboth # no duplicate lines or lines starting with space
shopt -s histappend    # append history instead of overwriting
HISTSIZE=1000
HISTFILESIZE=2000

# Check window size after each command
shopt -s checkwinsize

# Less: make it more friendly for non-text input
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Debian chroot identifier (used in prompt)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# <<< Bash basics <<<

# ==============================================================
# >>> Prompt >>>
# Default and starship prompt setup
# ==============================================================

# Set color prompt if terminal supports it
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# Starship prompt (custom config from Windows side)
export STARSHIP_CONFIG=/mnt/c/Users/boehmem/.config/starship.toml
eval "$(starship init bash)"
# <<< Prompt <<<

# ==============================================================
# >>> Aliases >>>
# Handy shell aliases
# ==============================================================

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alert for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" \
"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# <<< Aliases <<<

# ==============================================================
# >>> Bash completion >>>
# Load programmable completion if available
# ==============================================================

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
# <<< Bash completion <<<

# ==============================================================
# >>> Tools >>>
# Environment setups for installed tools
# ==============================================================
# XDG base directory
export XDG_CONFIG_HOME="$HOME/.config"

# Neovim
export PATH="$PATH:/opt/nvim/"

# Julia
export PATH="/opt/julia-1.11.6/bin:$PATH"

# Rust
. "$HOME/.cargo/env"

# fzf (fuzzy finder)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# <<< Tools <<<
