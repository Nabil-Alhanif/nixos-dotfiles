{ config, pkgs, inputs, ... }:

{
	imports = [
		./homeModules/swayfx.nix
		./homeModules/noctalia.nix
	];

	home.username = "nabil-alhanif";
	home.homeDirectory = "/home/nabil-alhanif-nixos";

	home.packages = with pkgs; [
		endless-sky

		# Python setup, mostly for school and whatnot
		(python3.withPackages(pypkgs: with pypkgs; [
			jupyterlab # Jupyter Lab, yk for school stuff
			ipykernel # A somewhat requirement?
			ipywidgets # UI

			# Some basic numerical / statistical packages
			pandas
			numpy
			matplotlib
		]))
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
