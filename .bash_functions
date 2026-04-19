function search_repositories() {
    local results=$(fd -t d -d 1 . "/c/Git" | fzf)

    if [ -z "$results" ]; then
        return
    fi

    cd "$results" || return
}

function fzhistory() {
    local cmd=$(history | awk '{$1=""; print $0}' | fzf --tac)
    [ -n "$cmd" ] && eval "$cmd"
}

function fzbranch() {
    local branch=$(git branch -a | sed 's/^[ *]*//' | fzf)
    git checkout "$branch"
}

function vf() {
    local file=$(fd -t f | fzf --preview 'head -20 {}')
    [ -n "$file" ] && code "$file"
}

function fzsln() {
    local sln=$(fd '\.sln$' /c/Git | fzf)
    if [ -n "$sln" ]; then
        cd "$(dirname "$sln")" || return
        devenv.exe "$sln" &
        cls
    fi
}

function bash-help() {
    clear
    cat << 'EOF'
==================================================================
||                    TERMINAL BASH HELP                        ||
==================================================================

AVAILABLE ALIASES:
------------------------------------------------------------------
  Navigation:
    gdir        → cd /c/Git
    cls         → clear
    ..          → cd ..

  Git:
    gpdev       → git pull origin develop
    gphere      → git pull origin (current branch)
    gpush       → git push origin (current branch)
    gs          → git status

  .NET:
    db          → dotnet build
    dr          → dotnet run
    dc          → dotnet clean
    dt          → dotnet test

CUSTOM FUNCTIONS:
------------------------------------------------------------------
  search_repositories()  → Search and enter repositories (Ctrl+F)
  fzhistory()            → Search history with fzf (Ctrl+H)
  fzbranch()             → Search and checkout branch (Ctrl+B)
  vf()                   → Open file in VS Code with preview
  fzsln()                → Search and open .sln in Visual Studio (Ctrl+O)
  bash-help()            → Show this help

KEYBOARD SHORTCUTS:
------------------------------------------------------------------
  Ctrl+F              → search_repositories
  Ctrl+B              → fzbranch
  Ctrl+H              → fzhistory
  Ctrl+O              → fzsln

CONFIGURATION FILES:
------------------------------------------------------------------
  ~/.bash_profile         → Main shell configuration
  ~/.dotfiles/.bash_aliases    → Aliases
  ~/.dotfiles/.bash_functions  → Custom functions
  ~/.dotfiles/.bash_keybindings   → Key bindings

===================================================================
EOF
}