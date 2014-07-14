set -g default-terminal "screen-256color"
set -g status-bg black
set -g status-fg white
set -g status-left '#[fg=green]#H'
set-window-option -g window-status-current-fg red

# vim-like key bindings
unbind h
bind h select-pane -L
unbind j
bind j select-pane -D
unbind k
bind k select-pane -U
unbind l # normally used for last-window
bind l select-pane -R

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
set-option -g pane-border-fg red
set-option -g pane-active-border-fg red
