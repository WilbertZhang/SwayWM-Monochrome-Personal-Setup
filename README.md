# SwayWM Monochrome Personal Setup

This is a fork of a Rice I really liked, so I customized it for my personal use. You are free to use this however you want.

## Included configs
- alacritty
- dunst
- sway
- waybar
- wofi
- gtklock (lock screen, styled to match the rest of the rice)
- gtk-3.0 / gtk-4.0 (GTK dark mode, styled to match the rest of the rice)
- quickshell (pop-up power menu and wallpaper picker, see `quickshell/menus/`)
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
- quickshell — hosts the power menu and wallpaper picker
- swaybg — draws the wallpaper (used by `quickshell/menus/scripts/set-wallpaper.sh`)
- JetBrainsMono Nerd Font
- Bibata-Modern-Classic

### Required for keybinds/modules already in these configs
- swayidle — idle handling / auto-lock (see `sway/sway-idle-lock-snippet.conf`)
- gtklock — lock screen (`sudo dnf copr enable wef/gtklock`
   `sudo dnf install gtklock`)
- grim + slurp — screenshot bind (`$mod+Shift+S`)
- brightnessctl — brightness keys
- wireplumber (provides `wpctl`) — volume keys
- NetworkManagerApplet (provides `nm-connection-editor`) — waybar network module click
- blueman — waybar bluetooth module click
- power-profiles-daemon — waybar power-profile module

### Required for GTK dark mode
- gsettings (from glib2) + gsettings-desktop-schemas — used by `sway/gtk-theme-snippet.conf`
- Adwaita-dark GTK theme — the Fedora package name has not been verified;
  check with `dnf search adwaita`

### Required for the system-info
- fastfetch — system info, configured in `fastfetch/config.jsonc`, also
  wired to print on every new shell (see `shell/bashrc-fastfetch-snippet.sh`)
- btop — resource monitor, themed via `btop/themes/monochrome.theme`
- cava — audio visualizer, configured in `cava/config`
- cmatrix — has no config file of its own; its look comes entirely from the
  `-C white` flag used in `sway/autostart-monitors-snippet.conf`

## Things you MUST edit before first use
- `sway/config`: the `output * bg ...` line was removed because wallpapers
  are now handled by `quickshell/menus/scripts/set-wallpaper.sh` (swaybg).
  Keeping both would make two programs draw the wallpaper.
- `quickshell/menus/modules/WallpaperPicker.qml`: set `wallpaperDir` to the
  folder that holds your wallpapers, e.g.
  `Quickshell.env("HOME") + "/Pictures/Background/"`.
  Move `midnight.jpg` (included in this repo) into that folder.
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
   for dir in alacritty btop cava dunst fastfetch gtk-3.0 gtk-4.0 gtklock quickshell sway waybar wofi; do
       [ -d ~/.config/"$dir" ] && cp -r ~/.config/"$dir" ~/.config/"$dir".bak.$(date +%Y%m%d_%H%M%S)
       cp -r "$dir" ~/.config/
   done
   ```
3. Do the manual edits listed above.
4. `sway/autostart-monitors-snippet.conf`, `sway/sway-idle-lock-snippet.conf`
   and `sway/gtk-theme-snippet.conf` are loaded via `include` from
   `sway/config`; do not paste them. If you use your own sway config, add
   those three include lines to it instead:
   ```
   include ~/.config/sway/autostart-monitors-snippet.conf
   include ~/.config/sway/sway-idle-lock-snippet.conf
   include ~/.config/sway/gtk-theme-snippet.conf
   ```
   If you use your own sway config, also add the Quickshell lines from the
   "Power menu and wallpaper picker" section below.
5. Append `shell/bashrc-fastfetch-snippet.sh` (or `shell/zshrc-fastfetch-snippet.sh`
   if you use zsh) to your shell rc file, so fastfetch prints on every new
   interactive shell/Alacritty window.
6. Pick your first wallpaper once so the restore script has something to load:
   ```
   sh ~/.config/quickshell/menus/scripts/set-wallpaper.sh ~/Pictures/Background/midnight.jpg
   ```
7. Log out and back in.

## Power menu and wallpaper picker
Both are full-screen pop-ups run by Quickshell from `quickshell/menus/`.
`sway/config` starts it with `exec qs -c menus -d` and opens each menu over IPC:

| Action           | Keybind    | Command                                  |
| ---------------- | ---------- | ---------------------------------------- |
| Power menu       | `$mod+x`   | `qs -c menus ipc call power toggle`      |
| Wallpaper picker | `$mod+p`   | `qs -c menus ipc call wallpaper toggle`  |

Lines added to `sway/config`:
```
exec qs -c menus -d
exec sh ~/.config/quickshell/menus/scripts/restore-wallpaper.sh
bindsym $mod+x exec qs -c menus ipc call power toggle
bindsym $mod+p exec qs -c menus ipc call wallpaper toggle
```
- Power menu: Lock (`gtklock -d`), Sleep, Log out, Reboot, Shut down. Edit the
  `actions` list in `quickshell/menus/modules/PowerMenu.qml` to change them.
  Keys: arrows or `h`/`l` to move, `Enter` to run, `1`-`5` to jump, `Esc` to close.
- Wallpaper picker: lists jpg, jpeg, png and webp files in `wallpaperDir`.
  Keys: arrows or `h`/`l` to browse, `Enter` to apply, `Esc` to close.
  The choice is saved to `~/.cache/quickshell-menus/wallpaper` and re-applied
  at login by `restore-wallpaper.sh`.
- Waybar: a `custom/power` button was added to `waybar/config` that opens the
  power menu, styled via `#custom-power` in `waybar/style.css`.
- Colors live in `quickshell/menus/config/Style.qml` (monochrome palette
  matching the rest of the rice).
- Debugging: run `qs -c menus` in a terminal to see QML errors.

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
- GTK dark mode: `gtk-3.0/` and `gtk-4.0/` hold `settings.ini` and `gtk.css`
  (monochrome color overrides). `sway/gtk-theme-snippet.conf` sets the
  GSettings dark-mode keys on every Sway start. The libadwaita color names
  in `gtk-4.0/gtk.css` may differ between versions; some apps may not
  recolor fully.
- Distro this was built/tested on: Fedora Sway Spin (official).
- The Quickshell menus are adapted from the `swaywmdots` repo
  (https://github.com/shadowofdominance/swaywmdots), whose README says to
  feel free to use, modify, and share. The Quickshell setup has not been
  verified on Fedora 44 yet.
- I used AI in a lot of these files.
- Anyone is free to redistribute, modify, and monetize this project.

## Personal Notes
- Uninstall Foot Terminal Emulator `sudo dnf remove foot`
- Uninstall firefox `sudo dnf remove firefox`
- Uninstall Sway Lock `sudo dnf remove swaylock`
- Uninstall rofi `sudo dnf remove rofi`
- Install Alacritty `sudo dnf install alacritty`
- Install Wofi `sudo dnf install wofi`
- Install GTKLock `sudo dnf copr enable wef/gtklock` then `sudo dnf install gtklock`
- Install Quickshell `sudo dnf install quickshell` (package availability on
  Fedora 44 not verified; check `dnf search quickshell`, a COPR may be needed)
- Install Swaybg `sudo dnf install swaybg` (may already be installed)
- Install Fastfetch `sudo dnf install fastfetch`
- Install Cava `sudo dnf install cava`
- Install Cmatrix `sudo dnf install cmatrix`
- Install Btop `sudo dnf install btop`

- Install JetBrainsMono Nerd Font: download the JetBrainsMono archive from the
    Nerd Fonts project's releases page, extract the .ttf files into
    ~/.local/share/fonts/, then run `fc-cache -f`
  
- Install Swayidle `sudo dnf install swayidle`
- Install Grim `sudo dnf install grim`
- Install Slurp `sudo dnf install slurp`
- Install Wireplumber `sudo dnf install wireplumber`
- Install Blueman `sudo dnf install blueman`
- Install Power-profiles-daemon `sudo dnf install power-profiles-daemon`
- Install Bibata-Modern-Classic `sudo dnf copr enable peterwu/rendezvous` then `sudo dnf install bibata-cursor-themes`
