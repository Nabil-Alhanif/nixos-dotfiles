{ pkgs, inputs, ... }: {
	environment.systemPackages = with pkgs; [
		zathura
		typst
		typstyle
		typst-live
	];
}
