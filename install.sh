#!/usr/bin/env bash
# another-monochrome-sway installer
# Copies each tool folder in this repo into ~/.config, backing up anything
# that already exists there first. Does NOT touch package installation and
# does NOT merge sway/idle-lock-snippet.conf or autostart-monitors-snippet.conf
# into sway/config, and does NOT merge shell/*-fastfetch-snippet.sh into your
# shell rc — see README.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
TOOLS=(alacritty sway waybar wofi dunst gtklock btop cava fastfetch)

echo "Installing another-monochrome-sway dotfiles from $REPO_DIR"
echo ""

for dir in "${TOOLS[@]}"; do
    src="$REPO_DIR/$dir"
    dest="$CONFIG_DIR/$dir"

    if [ ! -d "$src" ]; then
        echo "Skipping $dir (not found in repo)"
        continue
    fi

    if [ -d "$dest" ] && [ "$(ls -A "$dest" 2>/dev/null)" ]; then
        backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
        echo "Backing up existing $dest -> $backup"
        cp -r "$dest" "$backup"
    fi

    mkdir -p "$dest"
    cp -r "$src/." "$dest/"
    echo "Installed $dir"
done

echo ""
echo "Done. Manual steps still required before this works:"
echo "  1. Edit sway/config's 'output * bg' line to point at your own"
echo "     midnight.jpg path (not tuxedochan's home directory)."
echo "  2. Edit gtklock/config.ini and replace YOURUSER with your username."
echo "  3. Paste sway/idle-lock-snippet.conf and"
echo "     sway/autostart-monitors-snippet.conf into ~/.config/sway/config."
echo "  4. Append shell/bashrc-fastfetch-snippet.sh (or the zsh variant)"
echo "     to your shell rc file."
echo "  5. cmatrix has no config file; its look is set by the -C flag"
echo "     already included in the autostart snippet."
echo "  6. Run: swaymsg reload"
