# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
    inputs,
    lib,
    config,
    pkgs,
    ...
}: {
    # You can import other NixOS modules here
    imports = [
        # If you want to use modules from other flakes (such as nixos-hardware):
        # inputs.hardware.nixosModules.common-cpu-amd
        # inputs.hardware.nixosModules.common-ssd

        # You can also split up your configuration and import pieces of it here:
        # ./users.nix

        # Import your generated (nixos-generate-config) hardware configuration
        ./hardware-configuration.nix
    ];

    nixpkgs = {
        # You can add overlays here
        overlays = [
            # If you want to use overlays exported from other flakes:
            # neovim-nightly-overlay.overlays.default

            # Or define it inline, for example:
            # (final: prev: {
            #     hi = final.hello.overrideAttrs (oldAttrs: {
            #         patches = [ ./change-hello-to-hi.patch ];
            #     });
            # })
        ];
        # Configure your nixpkgs instance
        config = {
            # Disable if you don't want unfree packages
            allowUnfree = true;
        };
    };

	# Packages and programs
    environment.systemPackages = with pkgs; [
        neovim
		gcc
		cargo
		python3
		nodejs
    ];

	programs.thunar.enable = true;
	programs.file-roller.enable = true;
	programs.steam.enable = true;
	programs.zsh.enable = true;

    nix = let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
        settings = {
            # Enable flakes and new 'nix' command
            experimental-features = "nix-command flakes";
            # Opinionated: disable global registry
            flake-registry = "";
            # Workaround for https://github.com/NixOS/nix/issues/9574
            nix-path = config.nix.nixPath;
        };
        # Opinionated: disable channels
        channel.enable = false;

        # Opinionated: make flake registry and nix path match flake inputs
        registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Vancouver";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
    
	services.tumbler.enable = true;

	services.gvfs.enable = true;

	services.upower.enable = true;

	# Fingerprint
	systemd.services.fprintd = {
		wantedBy = [ "multi-user.target" ];
		serviceConfig.Type = "simple";
	};
	services.fprintd.enable = true;

	# Catppuccin!
	catppuccin = {
		enable = true;
		flavor = "mocha";
		accent = "mauve";
	};

    networking.hostName = "remys-thinkpad";

    users.users = {
        remy = {
            isNormalUser = true;
            description = "Remy";
            extraGroups = [ "networkmanager" "wheel" ];
			shell = pkgs.zsh;
            packages = with pkgs; [
            #    thunderbird
            ];
        };
    };

	virtualisation.virtualbox.host.enable = true;
	users.extraGroups.vboxusers.members = [ "remy" ];

    # Make non-NixOS executables work
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged programs
        # here, NOT in environment.systemPackages
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.05";
}
