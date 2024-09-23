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
	echo "  --help        Show this message."
	echo "  --no-editor   Commit any changes, push them, and rebuild the system, but don't open up the editor."
	echo "  --test        Download any changes to the configuration, add any changes, and rebuild the system, but don't commit or push any changes."
	echo "  --home        Only rebuild the home-manager configuration, not the system-wide configuration."
	echo "  --system      Only rebuild the system configuration, not the home-manager configuration."
	echo "  --garbage     Removes any garbage left over from older generations of the system."
	echo '  --update      Updates the flake lock file and pushes it to Github with a commit message of "System update".'
	echo
	echo "Examples:"
	echo "Configure the system without pushing any changes and only rebuilding the home-manager configuration."
	echo '  $ config --test --home'
	echo
	echo "Commit and push any changes to the configuration and rebuild only the system configuration."
	echo '  $ config --no-editor --system'
else
	sudo -v
	previous_dir=$(pwd)
	cd ~/nixos

	if check_match "--garbage" "$@"; then
		sudo nix-collect-garbage -d
		nix-collect-garbage -d
		sudo nixos-rebuild switch --flake .
		home-manager --flake . switch
	else
		if check_match "--update" "$@"; then
			git pull
			nix flake update
			git add .
			git commit -m "System update"
			git push
			sudo nixos-rebuild switch --flake .
			home-manager --flake . switch
		else
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
				home-manager --flake . switch
			fi
		fi
	fi

	cd $previous_dir
fi
