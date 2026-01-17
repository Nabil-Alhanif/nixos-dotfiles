{ pkgs, ... }: {
	virtualisation = {
		libvirtd = {
			enable = true;
			qemu = {
				package = pkgs.qemu_kvm;
				runAsRoot = true;

				# Folder sharing
				swtpm.enable = true;
			};
		};

		spiceUSBRedirection.enable = true;
	};

	programs.virt-manager.enable = true;

	environment.systemPackages = with pkgs; [
		dnsmasq
		virt-viewer
		spice-gtk
		virtio-win
	];
}
