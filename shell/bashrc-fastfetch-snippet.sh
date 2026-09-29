# --- Run fastfetch on every new interactive shell (e.g. each Alacritty window) ---
# NOT auto-loaded. Append this block by hand to ~/.bashrc
# (guarded so it does not fire in non-interactive/script shells)

if [[ $- == *i* ]] && [[ -z "$FASTFETCH_SHOWN" ]]; then
    FASTFETCH_SHOWN=1
    fastfetch
fi
