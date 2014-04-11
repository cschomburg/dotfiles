set -g default-terminal "screen-256color"
set -g status-bg black
set -g status-fg white
set -g status-left '#[fg=green]#H'
set-window-option -g window-status-current-fg red
#set -g escape-time 0

# Vim-aware window bindings
bind -n C-h run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_title}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
