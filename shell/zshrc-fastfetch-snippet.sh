# --- Run fastfetch on every new interactive shell (e.g. each Alacritty window) ---
# NOT auto-loaded. Append this block by hand to ~/.zshrc
# Only needed if you use zsh instead of bash — Fedora's default is bash.

if [[ -o interactive ]] && [[ -z "$FASTFETCH_SHOWN" ]]; then
    export FASTFETCH_SHOWN=1
    fastfetch
fi
