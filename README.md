This is a fork of a Rice I really liked so I wanted to customize it for my personal use you are free to use this however you want

## Included configs
- alacritty
- dunst
- sway
- waybar
- wofi
- fastfetch
- Cmatrix
- btop
- gtklock (lock screen, styled to match the rest of the rice)

## Dependencies

### Core
- sway
- waybar
- wofi
- alacritty
- dunst
- JetBrainsMono Nerd Font

### Required for keybinds/modules already in these configs
- swayidle — idle handling / auto-lock (see `sway/idle-lock-snippet.conf`)
- gtklock — lock screen (see `gtklock/`)
- grim + slurp — screenshot bind (`$mod+Shift+S`)
- brightnessctl — brightness keys
- wireplumber (provides `wpctl`) — volume keys
- NetworkManager (provides `nm-connection-editor`) — waybar network module click
- blueman — waybar bluetooth module click
- power-profiles-daemon — waybar power-profile module

### Optional / manual, not confirmed packaged anywhere
- "Future-dark-cursors" cursor theme, referenced in `sway/config`'s `seat` line.
  I have not verified this is available in any repo. If you don't have it,
  either install it manually from wherever you sourced it originally, or
  delete that `seat` line to use your system's default cursor theme.

## Things you MUST edit before first use
- `sway/config`: the `output * bg ...` line hardcodes
  `/home/tuxedochan/Downloads/midnight.jpg`. Move `midnight.jpg` (included in
  this repo) somewhere on your machine and change that path to match, e.g.
  `~/Pictures/midnight.jpg`.
- `gtklock/config.ini`: the `style=` line has a `YOURUSER` placeholder.
  Replace it with your actual Linux username.

## Install
1. Clone the repo:
   `git clone https://github.com/Tolepi/another-monochrome-sway`
2. Run the install script from inside the cloned folder:
   `./install.sh`
   This backs up any existing configs under `~/.config/<tool>.bak.<timestamp>`
   and copies these dotfiles into `~/.config/`.
3. Do the two manual edits listed above.
4. Merge `sway/idle-lock-snippet.conf` into `~/.config/sway/config` by hand.
   Sway does not auto-load extra files in its config directory, so this
   snippet is NOT wired in automatically — you have to paste its contents in
   yourself (this is intentional, so the installer never silently rewrites
   your `sway/config`).
5. Reload Sway: `swaymsg reload`, or log out and back in.

## Notes
- Screenshots save to `~/Pictures/screenshot_<timestamp>.png` — make sure
  `~/Pictures` exists.
- Distro this was built/tested on: Fedora Sway Spin (official).
- I used AI in a lot of these files
- Anyone is free to redistribute, modify, and monetize this project
