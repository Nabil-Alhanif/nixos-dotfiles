{ pkgs, lib, ... }:

{
	# Set Sway as the systemd target
	wayland.systemd.target = "sway-session.target";

	wayland.windowManager.sway = {
		enable = true;
		package = pkgs.swayfx; # Use SwayFX and not basic Sway
		checkConfig = false; # We're calling include /etc/sway/config.d -- it's not sandboxed under home, so checkConfig fails with Nix

		systemd.enable = true; # Provide graphical target, mainly for Noctalia

		config = rec {
			modifier = "Mod4";
			terminal = "kitty";
			menu = "noctalia-shell ipc call launcher toggle";

			# Keybindings
			keybindings = lib.mkOptionDefault {
				"${modifier}+Return" = "exec ${terminal}";
				"${modifier}+Shift+q" = "kill";
				"${modifier}+d" = "exec ${menu}";

				# Audio and Brightness (matches your util section)
				"XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
				"XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
				"XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
				"XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
				"XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
				"Print" = "exec grim";
			};

			# Input Configuration
			input = {
				"type:touchpad" = {
					dwt = "enabled";
					tap = "enabled";
					natural_scroll = "enabled";
					middle_emulation = "enabled";
					accel_profile = "adaptive";
					pointer_accel = "0.4";
				};
			};

			# Startup Commands
			startup = [
				{ command = "noctalia-shell"; }
			];

			bars = [];
		};

		extraConfig = ''
			# SwayFX Effects
			blur enable
			corner_radius 12
			shadows enable
			shadow_blur_radius 20

			# Window decoration (removing title bars for a cleaner look with Noctalia)
			default_border normal 2
			smart_borders on

			# Include system-specific snippets if they exist
			include /etc/sway/config.d/*
		'';
	};
}
