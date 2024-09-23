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

			if check_match "--help" "$@"; then
				echo "Usage: config [ options ]"
				echo "Configure and rebuild the system."
				echo
				echo "Options:"
				echo "--no-editor   Commit any changes, push them, and rebuild the system, but don't open up the editor."
				echo "--test        Download any changes to the configuration, add any changes, and rebuild the system, but don't commit or push any changes."
				echo "--home        Only rebuild the home-manager configuration, not the system-wide configuration."
				echo "--system      Only rebuild the system configuration, not the home-manager configuration."
			else
				sudo -v
				previous_dir=$(pwd)
				cd ~/nixos
				git pull

				if ! check_match "--no-editor" "$@"; then
					nvim .
				fi

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
			fi
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
