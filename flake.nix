{
	description = "A simple NixOS flake";

	inputs = {
		# NixOS official package source
		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixos-unstable";
		};

		# Home Manager
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		noctalia = {
			url = "github:noctalia-dev/noctalia-shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Zen browser lol
		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};

		nixos-hardware = {
			url = "github:NixOS/nixos-hardware/master";
		};

		winapps = {
			url = "github:winapps-org/winapps";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: {
		nixosConfigurations.NA-NFW16 = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				# Import previous configuration.nix
				./configuration.nix
				./virtualisation.nix
				./typst.nix

				# Add hardware model
				nixos-hardware.nixosModules.framework-16-7040-amd

				# Make home-manager as a module of NixOS
				home-manager.nixosModules.home-manager {
					home-manager.extraSpecialArgs = { inherit inputs; };
					home-manager.users.nabil-alhanif = import ./home.nix;
				}
			];
		};
	};
}
