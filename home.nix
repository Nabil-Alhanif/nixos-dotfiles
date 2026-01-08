{ config, pkgs, ... }:

{
	home.username = "nabil-alhanif";
	home.homeDirectory = "/home/nabil-alhanif-nixos";

	home.packages = with pkgs; [
		# endless-sky
	];

	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "Nabil-Alhanif";
				email = "nabil.alhanif@protonmail.com";
			};
		};
	};

	programs.fish = {
		enable = true;
		shellAliases = {
			ls = "eza -a --icons=always";
			ll = "eza -al --icons=always";
			lt = "eza -a --tree --level=1 --icons=always";
		};
	};

	programs.home-manager.enable = true;

	home.stateVersion = "25.11";
}
