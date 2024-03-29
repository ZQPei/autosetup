# set shell
set -g default-shell /bin/zsh
set -g history-limit 65535
set -g base-index 1
set -g pane-base-index 1

# set color 256
# set -g default-terminal "xterm-256color"

# set mouse
# set-window-option -g mouse on
set-option -g mouse on
set -g @scroll-down-exit-copy-mode "on"
set -g @scroll-without-changing-pane "on"
set -g @scroll-speed-num-lines-per-scroll "1"

# set rename
set-option -g allow-rename off

# bind -Tcopy-mode WheelUpPane send -N1 -X scroll-up
# bind -Tcopy-mode WheelDownPane send -N1 -X scroll-down

# set tmux prefix
set -g prefix C-a #
unbind C-b # C-b即Ctrl+b键，unbind意味着解除绑定
bind C-a send-prefix # 绑定Ctrl+a为新的指令前缀
# 从tmux v1.6版起，支持设置第二个指令前缀
set-option -g prefix2 ` # 设置一个不常用的`键作为指令前缀，按键更快些

# 绑定快捷键为r
bind r source-file ~/.tmux.conf \; display-message "Config reloaded.."

# split pane
unbind '"'
bind '-' splitw -v -c '#{pane_current_path}' # 垂直方向新增面板，默认进入当前目录
unbind %
bind '\' splitw -h -c '#{pane_current_path}' # 水平方向新增面板，默认进入当前目录

# 绑定Ctrl+hjkl键为面板上下左右调整边缘的快捷指令
bind -r ^k resizep -U 10 # 绑定Ctrl+k为往↑调整面板边缘10个单元格
bind -r ^j resizep -D 10 # 绑定Ctrl+j为往↓调整面板边缘10个单元格
bind -r ^h resizep -L 10 # 绑定Ctrl+h为往←调整面板边缘10个单元格
bind -r ^l resizep -R 10 # 绑定Ctrl+l为往→调整面板边缘10个单元格


# plugin tmux-better-mouse-mode
# run-shell /home/vis/pzq/.tmux/scroll_copy_mode.tmux

# scroll speed
# set-option -g mouse on
# set -g @scroll-speed-num-lines-per-scroll 1

