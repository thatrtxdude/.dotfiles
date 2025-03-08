#!/usr/bin/env bash
## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5
# Current Theme
dir="$HOME/.config/rofi/powermenu/type-4"
theme='style-3'
# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`
# Options
shutdown='⏻'
reboot=''
lock='󰌾'
suspend='󰤄'
logout='󰍃'
yes='yes'
no='no'
# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Goodbye ${USER}" \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}
# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/shared/confirm.rasi
}
# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}
# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}
# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			# Check for Void Linux (runit) or fallback to systemd
			if command -v loginctl &> /dev/null; then
				loginctl poweroff
			elif [ -d "/etc/runit" ]; then
				sudo shutdown -p now
			else
				systemctl poweroff
			fi
		elif [[ $1 == '--reboot' ]]; then
			# Check for Void Linux (runit) or fallback to systemd
			if command -v loginctl &> /dev/null; then
				loginctl reboot
			elif [ -d "/etc/runit" ]; then
				sudo reboot
			else
				systemctl reboot
			fi
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			amixer set Master mute
			# Check for Void Linux (runit) or fallback to systemd
			if command -v loginctl &> /dev/null; then
				loginctl suspend
			elif [ -d "/etc/runit" ]; then
				sudo zzz
			else
				systemctl suspend
			fi
		elif [[ $1 == '--logout' ]]; then
			if [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
				i3-msg exit
			elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
				qdbus org.kde.ksmserver /KSMServer logout 0 0 0
			elif [[ "$XDG_CURRENT_DESKTOP" == 'Hyprland' ]]; then
				hyprctl dispatch exit
			elif [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then
				# Alternative detection for Hyprland
				hyprctl dispatch exit
			fi
		fi
	else
		exit 0
	fi
}
# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		if [[ -x '/usr/bin/betterlockscreen' ]]; then
			betterlockscreen -l
		elif [[ -x '/usr/bin/i3lock' ]]; then
			i3lock
		elif [[ -x '/usr/bin/swaylock' ]]; then
			swaylock
		elif [[ -x '/usr/bin/hyprlock' ]]; then
			hyprlock
		fi
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
