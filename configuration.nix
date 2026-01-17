# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	# Use SystemD BootEFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Use latest kernel.
	boot.kernelPackages = pkgs.linuxPackages_zen;

	networking.hostName = "NA-NFW16"; # Define your hostname.

	# Configure network connections interactively with nmcli or nmtui.
	networking.networkmanager.enable = true;

	# Bluetooth
	hardware.bluetooth.enable = true;

	hardware.opengl = {
		enable = true;
	};

	services.power-profiles-daemon.enable = true;
	services.upower.enable = true;

	# Set your time zone.
	time.timeZone = "Canada/Pacific";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_CA.UTF-8";

	# Enable the X11 windowing system.
	services.xserver.enable = true;
	services.xserver.videoDrivers = [ "amdgpu" ];
	programs.xwayland.enable = true;

	security.polkit.enable = true;

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound.
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;

	programs.fish.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.nabil-alhanif = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
		shell = pkgs.fish;
		home = "/home/nabil-alhanif-nixos";
	};

	programs.steam.enable = true;
	programs.steam.extraCompatPackages = with pkgs; [
		proton-ge-bin
	];

	# List packages installed in system profile.
	# You can use https://search.nixos.org/ to find more packages (and options).
	environment.systemPackages = with pkgs; [
		vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
		grim # Screenshot Functionality
		slurp # Screenshot Functionality
		wl-clipboard # wl-copy and wl-paste for copy/paste from stdin/stdout
		kitty # Terminal emulator
		swayfx # Uhhhh idk????????
		wget
		rofi # Launcher, hopefully
		neovim
		btop
		vscodium
		protonvpn-gui
		eza
		git
		gcc
		fastfetch
		inputs.zen-browser.packages."${system}".default
		ripgrep
		networkmanagerapplet
		zstd
		qalculate-qt
		ranger
		kdePackages.dolphin
		imv
		vlc
	];

	fonts.packages = with pkgs; [
		nerd-fonts.fira-code
	];

	# Enable gnome keyring (like why? Idk, we'll found out I guess :shrug:)
	services.gnome.gnome-keyring.enable = true;

	# Enable SwayWM
	programs.sway = {
		enable = true;
		package = pkgs.swayfx;
		wrapperFeatures.gtk = true;
	};

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"steam"
		"steam-unwrapped"
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.11"; # Did you read the comment?
}
