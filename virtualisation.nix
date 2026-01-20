# https://www.youtube.com/watch?v=rCVW8BGnYIc

{ config, pkgs, ... }: {
	programs.dconf.enable = true;

	users.users.nabil-alhanif.extraGroups = [ "libvirtd" "kvm" ];

	programs.virt-manager.enable = true;

	environment.systemPackages = with pkgs; [
		dnsmasq
		virt-manager
		virt-viewer
		spice
		spice-gtk
		spice-protocol
		virtio-win
		win-spice
		adwaita-icon-theme
	];

	virtualisation = {
		libvirtd = {
			enable = true;
			qemu = {
				package = pkgs.qemu_kvm;

				# Folder sharing
				swtpm.enable = true;

				# Now enabled by default
				# ovmf = {
				# 	enable = true;
				# 	packages = [ pkgs.OVMFFull.fd ];
				# };
			};
		};

		spiceUSBRedirection.enable = true;
	};

	services.spice-vdagentd.enable = true;

	services.samba = {
		enable = true;
		securityType = "user";
		openFirewall = true;
		settings = {
			global = {
				"workgroup" = "WORKGROUP";
				"security" = "user";
				"interfaces" = "lo virbr0";
				"bind interfaces only" = "yes";
				"hosts allow" = "127. 192.168. localhost";
				"hosts deny" = "0.0.0.0/0";
				"map to guest" = "bad user";
			};
			"Data" = {
				"path" = "/mnt/data";
				"browseable" = "yes";
				"read only" = "no";
				"guest ok" = "no";
				"create mask" = "0644";
				"directory mask" = "0755";
			};
			"WindowsData" = {
				"path" = "/mnt/windows";
				"browseable" = "yes";
				"read only" = "no";
				"guest ok" = "no";
				"create mask" = "0644";
				"directory mask" = "0755";
			};
		};
	};
}
