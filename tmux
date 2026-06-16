set -g default-terminal "tmux-256color"
#set -ga terminal-overrides "xterm*:XT:smcup@:rmcup@"
#set -ga terminal-overrides ",*256col*:Tc"

set -g status-style bg=default
set -g status-style fg=white
set -g status-left '#[fg=green]#H '
set -g status-right ''
set -g status-left-length 12
set -g status-right-length 70
set -g status-interval 30
set-window-option -g window-status-current-style fg=red
set-window-option -g mode-keys vi
set -sg escape-time 0
set -g history-limit 10000
set -g mouse on

# bind-key -t vi-copy v begin-selection
bind-key v setw synchronize-panes

# X clipboard
# bind-key -t vi-copy y copy-pipe "xsel -i -p -b"
# bind-key C-y run "xsel -o -b | tmux load-buffer - ; tmux paste-buffer"

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

#set-option -g pane-border-style fg=colour8
unbind C-b
set-option -g prefix C-a
bind C-a send-prefix
bind a send-prefix

set-option -g pane-border-style fg=red
set-option -g pane-active-border-style fg=red
setw -g aggressive-resize

set -g @fingers-skip-health-check '1'
run-shell ~/.tmux/plugins/tmux-fingers/tmux-fingers.tmux
