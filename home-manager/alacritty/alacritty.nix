{ ... }:
{
	programs.alacritty = {
		enable = true;
		settings = {
			env = {
				TERM = "xterm-256color";
			};
			font = {
				normal = {
					family = "JetBrainsMono NerdFont";
					style = "Regular";
				};
			};
		};
	};
}
