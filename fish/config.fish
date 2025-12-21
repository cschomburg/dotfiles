set -x GOPATH "$HOME/code/go"
set NPM_PACKAGES "$HOME/.npm-packages"

fish_add_path \
    "$GOPATH/bin" \
    "$DOTFILES/bin" \
    "$DOTFILES/private/bin" \
    "$HOME/bin" \
    "$HOME/.npm-packages/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.deno/bin" \
    "$HOME/.rd/bin" \
    "$HOME/.local/bin"

alias cp='cp -vi'
alias mv='mv -v'
alias ag='rg -S'
alias top="htop"
alias curl="curlie"
alias xclipb='xclip -selection clipboard'
alias tf="terraform"
alias k="kubectl"

set -x EDITOR "nvim"
set -x VISUAL "nvim"
set -x MANPAGER "nvim +Man!"

eval (/opt/homebrew/bin/brew shellenv)

starship init fish | source
zoxide init fish | source
fzf --fish | source
atuin init fish | source
