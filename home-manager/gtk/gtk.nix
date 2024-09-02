{ pkgs, ... }:
{
	gtk = {
		enable = true;
		font = {
			name = "Inter";
			size = 11;
		};
		
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.catppuccin-papirus-folders.override {
				flavor = "mocha";
				accent = "mauve";
			};
		};
	};
}
