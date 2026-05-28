#!/bin/bash

# Eventuell alte tmux-Session ("dev") killen, um sauber zu starten
tmux kill-session -t dev > /dev/null 2>&1

# Neue detached (Hintergrund) tmux-Session erstellen:
#   Name der Session: "dev", erstes Fenster heißt "nvim", startet in ~/ und führt nvim aus
tmux new-session -d -s dev -n nvim -c ~/ nvim

# Das zweite Fenster in dieser Session erstellen:
#    Name: "bash", startet ebenfalls im Home-Verzeichnis (~/) mit deiner Standard-Shell
tmux new-window -t dev -n bash -c ~/

# Sicherstellen, dass das Neovim-Fenster beim Start fokussiert ist
tmux select-window -t dev:nvim

uwsm app -- zen.desktop > /dev/null 2>&1 &
ghostty --title="ghostty-tmux" -e tmux attach-session -t dev > /dev/null 2>&1 &
uwsm app -- chromium --app=https://gemini.google.com/app > /dev/null 2>&1 &

# Die Sortierschleife fängt die Fenster ab, sobald sie geladen sind
(
    for i in {1..12}; do
        hyprctl dispatch movetoworkspacesilent "1,class:^zen$" > /dev/null 2>&1
        hyprctl dispatch movetoworkspacesilent "2,title:^ghostty-tmux$" > /dev/null 2>&1
        hyprctl dispatch movetoworkspacesilent "3,class:^chrome-gemini\.google\.com__app-Default$" > /dev/null 2>&1
        sleep 0.5
    done
) &

# Standardmäßig direkt auf Workspace 2 schalten
hyprctl dispatch workspace 2 > /dev/null 2>&1
