//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import qs.modules

ShellRoot {
    WallpaperPicker { id: wallpaper }
    PowerMenu       { id: power }

    IpcHandler {
        target: "wallpaper"
        function toggle(): void { wallpaper.toggle() }
    }
    IpcHandler {
        target: "power"
        function toggle(): void { power.toggle() }
    }
}
