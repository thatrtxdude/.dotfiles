# ThinkPad .dotfiles
These are the dotfiles I use on my ThinkPad X270. The goal here was to create something minimal and light, with a focus on productivity, sort of.

# Dependencies
The biggest difference from the main branch is that this uses Sway (specifically SwayFX) rather than Hyprland. Alacritty has also been replaced with foot.

For actual dependencies, this branch requires the following packages:
`swayfx rofi-wayland autotiling polkit-gnome copyq wbg grimshot waybar`

Nerd fonts are also a hard-requirement, as I use Blex Mono Nerd Font and JetBrainsMonoNL Nerd Font extensively.

# Yazi
My Yazi config requires additional plugins that aren't included in these dotfiles. Install them using:

`ya pack -a yazi-rs/plugins:hide-preview`

`ya pack -a yazi-rs/plugins:full-border`
