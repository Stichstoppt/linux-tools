#!/bin/bash

# Eventuell alte tmux-Session ("dev") killen, um sauber zu starten
tmux kill-session -t dev > /dev/null 2>&1

# Neue detached (Hintergrund) tmux-Session erstellen:
#    Name der Session: "dev", erstes Fenster heißt "nvim", startet in ~/ und führt nvim aus
tmux new-session -d -s dev -n nvim -c ~/ nvim

# Das zweite Fenster in dieser Session erstellen:
#    Name: "bash", startet ebenfalls im Home-Verzeichnis (~/) mit deiner Standard-Shell
tmux new-window -t dev -n bash -c ~/

# Sicherstellen, dass das Neovim-Fenster beim Start fokussiert ist
tmux select-window -t dev:nvim

# tmux attach in aktuellem ghosty fenster
exec tmux attach-session -t dev
