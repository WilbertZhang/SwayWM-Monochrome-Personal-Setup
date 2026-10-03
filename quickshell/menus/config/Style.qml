pragma Singleton
import QtQuick
import Quickshell

// Shared look for every menu (wallpaper picker, Wi-Fi, Bluetooth, power...).
// Change a value here and all menus follow.
Singleton {
    // ---- Dracula palette ----
    readonly property color bg:        "#000000"
    readonly property color surface:   "#1c1c1c"
    readonly property color fg:        "#e0e0e0"
    readonly property color muted:     "#767676"
    readonly property color red:       "#f7768e"

    // ---- Semantic colours (use these in menus) ----
    readonly property color accent:    "#acacac"
    readonly property color scrim:     Qt.alpha(bg, 0.55)
    readonly property color panel:     Qt.alpha(bg, 0.92)
    readonly property color outline:   Qt.alpha(fg, 0.12)

    // ---- Shape ----
    readonly property int radius:      22     // big cards
    readonly property int radiusSmall: 12     // pills, buttons
    readonly property int spacing:     14
    readonly property int borderWidth: 2

    // ---- Type ----
    readonly property string font:     "JetBrainsMono Nerd Font"
    readonly property int fontSmall:   12
    readonly property int fontNormal:  14
    readonly property int fontLarge:   18

    // ---- Motion (ms) ----
    readonly property int animFast:    150
    readonly property int animMed:     260
    readonly property int animSlow:    420
}
