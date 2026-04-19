export PATH="$PATH:$HOME/.bin"

export ALIASES="$HOME/.dotfiles/.bash_aliases"
if [ -f "$ALIASES" ]; then
    source "$ALIASES"
fi

export FUNCTIONS="$HOME/.dotfiles/.bash_functions"
if [ -f "$FUNCTIONS" ]; then
    source "$FUNCTIONS"
fi

export BINDIR="$HOME/.dotfiles/.bash_keybindings"
if [ -f "$BINDIR" ]; then
    source "$BINDIR"
fi

export PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'
export PS1='\[\e[38;5;92m\]\w\[\e[38;5;220m\]${PS1_CMD1}\[\e[0m\] \$ '