# ThinkPad .dotfiles
These are the dotfiles I use on my ThinkPad X270. The goal here was to create something minimal and light, with a focus on productivity, sort of.

# Dependencies
The biggest difference from the main branch is that this uses Sway (specifically SwayFX) rather than Hyprland. Alacritty has also been replaced with foot.

For actual dependencies, this branch requires the following packages:
`swayfx rofi-wayland autotiling polkit-gnome copyq wbg grimshot waybar helix`

Nerd fonts are also a hard-requirement, as I use Blex Mono Nerd Font and JetBrainsMonoNL Nerd Font extensively.

# Disclaimer
Some scripts/applications that I use in these dotfiles were written by me, but these haven't been uploaded yet as I don't consider them quite done just yet. A noteable example for this would be the pwctl.py script that I use in my waybar config. For now, I encourage replacing this with something like pavucontrol (GUI) or pulsemixer (TUI).

# Yazi
My Yazi config requires additional plugins that aren't included in these dotfiles. Install them using:

`ya pack -a yazi-rs/plugins:hide-preview`

`ya pack -a yazi-rs/plugins:full-border`
