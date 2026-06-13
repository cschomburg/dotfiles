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
alias tf="terraform"
alias k="kubectl"

set -x EDITOR "nvim"
set -x VISUAL "nvim"
set -x MANPAGER "nvim +Man!"

brew shellenv | source
starship init fish | source
zoxide init fish | source
fzf --fish | source
atuin init fish | source

# pnpm
set -gx PNPM_HOME "$HOME/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
