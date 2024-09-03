{ ... }:
{
	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			monitor = ", preferred, auto, 1";

			exec-once = [
				"hyprpaper"
				"ags"
			];
			
			env = [
				"XCURSOR_SIZE, 24"
				"HYPRCURSOR_SIZE, 24"
			];

			general = {
				gaps_in = 10;
				gaps_out = 20;
				border_size = 2;
				"col.active_border" = "rgb(cba6f7)";
    			"col.inactive_border" = "rgb(f5e0dc)";
			};

			decoration.drop_shadow = false;

			animations = {
				enabled = true;
				bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
				animation = [
					"windows, 1, 7, myBezier"
    				"windowsOut, 1, 7, default, popin 80%"
    				"border, 1, 10, default"
    				"borderangle, 1, 8, default"
    				"fade, 1, 7, default"
    				"workspaces, 1, 6, default"
				];
			};

			dwindle = {
				pseudotile = true;
				preserve_split = true;
			};

			bind = [
				# TODO: change to use options or something
				"SUPER, Q, exec, alacritty"
				"SUPER, C, killactive,"
				"SUPER, M, exit,"
				"SUPER, E, exec, thunar"
				"SUPER, V, togglefloating,"
				"SUPER, W, exec, firefox"
				"SUPER, R, exec, wofi --show drun --prompt 'Search Programs'"
				"SUPER, P, pseudo,"
				"SUPER, S, togglesplit,"

				"SUPER, H, movefocus, l"
				"SUPER, L, movefocus, r"
				"SUPER, K, movefocus, u"
				"SUPER, J, movefocus, d"

				"SUPER SHIFT, H, swapwindow, l"
				"SUPER SHIFT, L, swapwindow, r"
				"SUPER SHIFT, K, swapwindow, u"
				"SUPER SHIFT, J, swapwindow, d"

				"SUPER, 1, workspace, 1"
				"SUPER, 2, workspace, 2"
				"SUPER, 3, workspace, 3"
				"SUPER, 4, workspace, 4"
				"SUPER, 5, workspace, 5"
				"SUPER, 6, workspace, 6"
				"SUPER, 7, workspace, 7"
				"SUPER, 8, workspace, 8"
				"SUPER, 9, workspace, 9"
				"SUPER, 0, workspace, 10"

				"SUPER SHIFT, 1, movetoworkspace, 1"
				"SUPER SHIFT, 2, movetoworkspace, 2"
				"SUPER SHIFT, 3, movetoworkspace, 3"
				"SUPER SHIFT, 4, movetoworkspace, 4"
				"SUPER SHIFT, 5, movetoworkspace, 5"
				"SUPER SHIFT, 6, movetoworkspace, 6"
				"SUPER SHIFT, 7, movetoworkspace, 7"
				"SUPER SHIFT, 8, movetoworkspace, 8"
				"SUPER SHIFT, 9, movetoworkspace, 9"
				"SUPER SHIFT, 0, movetoworkspace, 10"

				"SUPER, return, fullscreen, 1"
				"SUPER SHIFT, return, fullscreen, 0"

				", XF86MonBrightnessUp, exec, brightnessctl set +5%"
				", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

				", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			];

			bindm = [
				"SUPER, mouse:272, movewindow"
				"SUPER, mouse:273, resizewindow"
			];
			
			binde = [
				", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
				", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"

				"SUPER CTRL, H, resizeactive, -20 0"
				"SUPER CTRL, L, resizeactive, 20 0"
				"SUPER CTRL, K, resizeactive, 0 -20"
				"SUPER CTRL, J, resizeactive, 0 20"
			];

			windowrule = [
				"workspace 1, ^firefox$"
				"workspace 2, ^Alacritty$"
			];

			windowrulev2 = [ "suppressevent maximize, class:.*" ];
		};
	};
}
