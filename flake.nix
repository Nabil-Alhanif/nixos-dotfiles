{
	description = "A simple NixOS flake";

	inputs = {
		# NixOS official package source
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations.NA-NFW16 = nixpkgs.lib.nixosSystem {
			modules = [
				# Import previous configuration.nix
				./configuration.nix
			];
		};
	};
}
