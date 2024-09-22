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

		# Fonts
		(nerdfonts.override {fonts = ["JetBrainsMono"];})
		inter
		jetbrains-mono

		# Scripts
		(writeShellScriptBin "config" ''
			check_match() {
			    local match_string="$1"
			    shift

			    for arg in "$@"; do
			   	 if [[ "$arg" == "$match_string" ]]; then
			   		 return 0
			   	 fi
			    done

			    return 1
			}

			sudo -v
			previous_dir=$(pwd)
			cd ~/nixos
			git pull
			nvim .
			git add .

			if ! check_match "--test" "$@"; then
				read -p "Commit message: " message
				git commit -m "$message"
				git push
			fi
			
			if ! check_match "--home" "$@"; then
				sudo nixos-rebuild switch --flake .
			fi

			if ! check_match "--system" "$@"; then
				nix run home-manager -- --flake . switch
			fi

			cd $previous_dir
		'')

		(writeShellScriptBin "update" ''
			previous_dir=$(pwd)
			cd ~/nixos
			git pull
			nix flake update
			git add .
			git commit -m "System update"
			git push
			sudo nixos-rebuild switch --flake .
			nix run home-manager -- --flake . switch
			cd $previous_dir
		'')
	];
}
