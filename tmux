set -g default-terminal "screen-256color"
set -g status-bg black
set -g status-fg white
set -g status-left '#[fg=green]#H '
set -g status-right '#[fg=green]#T '
set-window-option -g window-status-current-fg red
set-window-option -g mode-keys vi
set -sg escape-time 0
set -g history-limit 10000

bind-key -t vi-copy v begin-selection

# X clipboard
bind-key -t vi-copy y copy-pipe "xsel -i -p -b"
bind-key C-y run "xsel -o -b | tmux load-buffer - ; tmux paste-buffer"

# simple resizing
unbind Left
bind -r Left resize-pane -L 5
unbind Right
bind -r Right resize-pane -R 5
unbind Down
bind -r Down resize-pane -D 5
unbind Up
bind -r Up resize-pane -U 5

# titles
set -g set-titles on
set -g set-titles-string "#W.#T"
set -g terminal-overrides "xterm*:XT:smcup@:rmcup@"

#set-option -g pane-border-fg colour8
unbind C-b
set-option -g prefix C-a
bind C-a send-prefix
bind a send-prefix

set-option -g pane-border-fg red
set-option -g pane-active-border-fg red
setw -g aggressive-resize
