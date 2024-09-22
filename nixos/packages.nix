{ inputs, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        neovim
		gcc
		cargo
		python3
		nodejs
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

		# Scripts
		(writeShellScriptBin "config" ''
			check_match() {
			    local match_string="$1"
			    shift

			    for arg in "$@"; do
			   	 if [[ "$arg" == "$match_string" ]]; then
			   		 echo "Match found: $arg"
			   		 return 0
			   	 fi
			    done

			    echo "No match found."
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

	programs.thunar.enable = true;
	programs.file-roller.enable = true;
	programs.steam.enable = true;
	programs.tmux.enable = true;

	# Add fonts
	fonts.packages = with pkgs; [
		(nerdfonts.override {fonts = ["JetBrainsMono"];})
		inter
		jetbrains-mono
		liberation_ttf
	];
}
