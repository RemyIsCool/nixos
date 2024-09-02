{ ... }:
{
	home.file."Pictures/wallpaper.png".source = ./wallpaper.png;

	services.hyprpaper = {
		enable = true;
		settings = {
			preload = "~/Pictures/wallpaper.png";
			wallpaper = ", ~/Pictures/wallpaper.png";
		};
	};
}
