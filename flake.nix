{
	description = "A simple NixOS flake";

	inputs = {
		# NixOS official package source
		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixos-unstable";
		};

		# Zen browser lol
		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};
	};

	outputs = { self, nixpkgs, zen-browser, ... }@inputs: {
		nixosConfigurations.NA-NFW16 = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				# Import previous configuration.nix
				./configuration.nix
			];
		};
	};
}
