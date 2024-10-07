{ inputs, pkgs, ... }:
{
	home.packages = with pkgs; [
		# Programs
		brightnessctl
		eza
		fastfetch
		keepassxc
		xfce.ristretto
		inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.godot_4
		libresprite
		vlc
		grim
		wl-clipboard
		teams-for-linux
		libreoffice
		wofi-emoji
		dconf
		pnpm
		inkscape
		gimp
		blender

		# Fonts
		(nerdfonts.override {fonts = ["JetBrainsMono"];})
		inter
		jetbrains-mono

		# Scripts
		(writeShellScriptBin "config" (builtins.readFile ./config.sh))
	];
}
