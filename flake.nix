{
  description = "My nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
	nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

	# Catppuccin
	catppuccin.url = "github:catppuccin/nix";

	# Firefox Addons
	firefox-addons = {
		url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	# Aylur's gtk shell
	ags.url = "github:Aylur/ags";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
	catppuccin,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      remyf-thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
			./nixos/configuration.nix
			catppuccin.nixosModules.catppuccin
		];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "remy@remyf-thinkpad" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [
			./home-manager/home.nix
			catppuccin.homeManagerModules.catppuccin
		];
      };
    };
  };
}
