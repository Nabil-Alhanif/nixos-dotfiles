{ pkgs, inputs, ... }:

{
	# Import the home manager module for noctalia
	imports = [
		inputs.noctalia.homeModules.default
	];

	# configure options
	programs.noctalia-shell = {
		enable = true;

		settings = {
			bar = {
				density = "compact";
				position = "top";
				showCapsule = false;
				widgets = {
					left = [
						{
							id = "ControlCenter";
							useDistroLogo = true;
						}
						{
							hideUnoccupied = false;
							id = "Workspace";
						}
					];
					center = [
						{
							id = "ActiveWindow";
						}
					];
					right = [
						{
							id = "WiFi";
						}
						{
							id = "Bluetooth";
						}
						{
							alwaysShowPercentage = false;
							id = "Battery";
							warningThreshold = 30;
						}
						{
							formatHorizontal = "HH:mm";
							formatVertical = "HH mm";
							id = "Clock";
							useMonospacedFont = true;
							usePrimaryColor = true;
						}
					];
				};
			};
			location = {
				monthBeforeDay = false; # I am not SDA, make my body shivers....
				name = "Vancouver, Canada";
			};
		};
	};
}
