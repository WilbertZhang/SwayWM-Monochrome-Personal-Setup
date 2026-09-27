# SwayWM Monochrome Personal Setup

This is a fork of a Rice I really liked, so I customized it for my personal use. You are free to use this however you want.

## Included configs
- alacritty
- dunst
- sway
- waybar
- wofi
- gtklock (lock screen, styled to match the rest of the rice)
### Terminal Visuals
- fastfetch
- cava
- Cmatrix (its color is set only via the CLI flag in the exec line (`-C white`); it doesn't accept hex colors)
- btop

## Dependencies

### Core
- sway
- waybar
- wofi
- alacritty
- dunst
- gtklock (lock screen, styled to match the rest of the rice)
- JetBrainsMono Nerd Font

### Required for keybinds/modules already in these configs
- swayidle — idle handling / auto-lock (see `sway/sway-idle-lock-snippet.conf`)
- gtklock — lock screen (`sudo dnf copr enable wef/gtklock`
   `sudo dnf install gtklock`)
- grim + slurp — screenshot bind (`$mod+Shift+S`)
- brightnessctl — brightness keys
- wireplumber (provides `wpctl`) — volume keys
- NetworkManager (provides `nm-connection-editor`) — waybar network module click
- blueman — waybar bluetooth module click
- power-profiles-daemon — waybar power-profile module

### Required for the system-info
- fastfetch — system info, configured in `fastfetch/config.jsonc`, also
  wired to print on every new shell (see `shell/bashrc-fastfetch-snippet.sh`)
- btop — resource monitor, themed via `btop/themes/monochrome.theme`
- cava — audio visualizer, configured in `cava/config`
- cmatrix — has no config file of its own; its look comes entirely from the
  `-C white` flag used in `sway/autostart-monitors-snippet.conf`

## Things you MUST edit before first use
- `sway/config`: the `output * bg ...` line hardcodes
  `/home/YOURUSER/Downloads/midnight.jpg`. Move `midnight.jpg` (included in
  this repo) somewhere on your machine and change that path to match, e.g.
  `~/Pictures/midnight.jpg`.
- `gtklock/config.ini`: the `style=` line has a `YOURUSER` placeholder.
  Replace it with your actual Linux username.

## Install
1. Clone the repo:
   ```
   git clone https://github.com/Wltrz/SwayWM-Monochrome-Personal-Setup
   cd SwayWM-Monochrome-Personal-Setup
   ```
2. Copy the dotfiles into `~/.config/`, backing up anything already there:
   ```
   for dir in alacritty btop cava dunst fastfetch gtklock sway waybar wofi; do
       [ -d ~/.config/"$dir" ] && cp -r ~/.config/"$dir" ~/.config/"$dir".bak.$(date +%Y%m%d_%H%M%S)
       cp -r "$dir" ~/.config/
   done
   ```
3. Do the two manual edits listed above.
4. Merge `sway/sway-idle-lock-snippet.conf` and `sway/autostart-monitors-snippet.conf`
   into `~/.config/sway/config` by hand. Sway does not auto-load extra files
   in its config directory, so these snippets are NOT wired in automatically
   — you have to paste their contents in yourself (this is intentional, so
   nothing ever silently rewrites your `sway/config`).
5. Append `shell/bashrc-fastfetch-snippet.sh` (or `shell/zshrc-fastfetch-snippet.sh`
   if you use zsh) to your shell rc file, so fastfetch prints on every new
   interactive shell/Alacritty window.
6. Reload Sway: `swaymsg reload`, or log out and back in.

## Notes
- Screenshots save to `~/Pictures/screenshot_<timestamp>.png` — make sure
  `~/Pictures` exists.
- On boot, `sway/autostart-monitors-snippet.conf` opens fastfetch, btop,
  cava, and cmatrix each in their own floating Alacritty window. fastfetch
  normally exits right after printing, so its window keeps a shell open
  behind it instead of closing immediately.
- cmatrix has no theme file: its color comes from the `-C` flag (ANSI color
  names only, no hex), set to `white` in the autostart snippet to fit the
  grayscale palette.
- btop's theme keys were written against the commonly documented format;
  if your installed version rejects any key, compare against
  `/usr/share/btop/themes/default.theme` and adjust.
- Distro this was built/tested on: Fedora Sway Spin (official).
- I used AI in a lot of these files.
- Anyone is free to redistribute, modify, and monetize this project.

## Personal Notes
- Uninstall Foot Terminal Emulator `sudo dnf remove foot`
- Uninstall firefox `sudo dnf remove firefox`
- Uninstall Sway Lock `sudo dnf remove swaylock`
- Uninstall rofi `sudo dnf remove rofi`
- Install Alacritty `sudo dnf install alacritty`
- Install Wofi `sudo dnf install wofi`
- Install GTKLock `sudo dnf install gtklock`
- Install Fastfetch `sudo dnf install fastfetch`
- Install Cava `sudo dnf install cava`
- Install Cmatrix `sudo dnf install cmatrix`
- Install Btop `sudo dnf install btop`
- Install JetBrainsMono Nerd Font `sudo dnf install nerdfonts`
- Install Swayidle `sudo dnf install swayidle`
- Install Grim `sudo dnf install grim`
- Install Slurp `sudo dnf install slurp`
- Install Wireplumber `sudo dnf install wireplumber`
- Install Blueman `sudo dnf install blueman`
- Install Power-profiles-daemon `sudo dnf install power-profiles-daemon`
