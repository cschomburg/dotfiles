# TMUX autostart new session or connect to previous
if type tmux &>/dev/null
    if [ -z "$TMUX" ]
        if tmux -q has-session -t main
            exec tmux attach-session -t main
        else
            exec tmux new-session -s main
        end
    end
end

set -x GOPATH "$HOME/code/go"
set NPM_PACKAGES "$HOME/.npm-packages"

fish_add_path \
    "$GOPATH/bin" \
    "$DOTFILES/bin" \
    "$DOTFILES/private/bin" \
    "$HOME/bin" \
    "$HOME/.npm-packages/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.deno/bin"

alias cp='cp -vi'
alias mv='mv -v'
alias ag='rg -S'
alias top="htop"
alias curl="curlie"

set -x EDITOR "nvim"
set -x VISUAL "nvim"
set -x MANPAGER "nvim +Man!"

starship init fish | source
atuin init fish | source
zoxide init fish | source
