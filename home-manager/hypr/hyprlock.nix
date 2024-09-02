{ ... }:
let
	time_settings = {
		color = "rgb(cba6f7)";
		font_size = 180;
		font_family = "Inter Bold";
		halign = "center";
		valign = "center";
	};
in
{
	programs.hyprlock = {
		enable = true;
		settings = {
			background = {
				color = "rgb(1e1e2e)";
			};
			label = [
				({ text = "cmd[update:1000] date +%I"; position = "0, 200"; } // time_settings)
				({ text = "cmd[update:1000] date +%M"; position = "0, 0"; } // time_settings)
				{
					text = "cmd[update:1000] date +'%a %b %-d'";
					halign = "center";
					valign = "center";
					font_family = "Inter";
					color = "rgb(cdd6f4)";
					position = "0, -40";
					font_size = 35;
				}
			];
			input-field = {
				halign = "center";
				valign = "center";
				position = "0, -180";
				outline_thickness = 2;
				dots_rounding = -2;
				outer_color = "rgb(cba6f7)";
				inner_color = "rgb(1e1e2e)";
				font_color = "rgb(cdd6f4)";
				fade_on_empty = false;
				placeholder_text = ''<span font_family="Inter" color="##7f849c">Enter Password</span>'';
				check_color = "rgb(f9e2af)";
				fail_color = "rgb(f38ba8)";
				fail_text = ''<span font_family="Inter" color="##f38ba8">Incorrect Password</span>'';
				rounding = 0;
			};
		};
	};
}
