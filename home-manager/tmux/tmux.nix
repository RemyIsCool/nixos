{ pkgs, ... }:
{
	programs.tmux = {
		enable = true;
		mouse = true;
		shortcut = "a";
		baseIndex = 1;
		escapeTime = 0;
		terminal = "screen-256color";
		extraConfig = /*tmux*/ ''
			set -ga terminal-overrides ",xterm-256color:Tc"
			set -g terminal-features "xterm-256color:Tc"
		'';
		plugins = with pkgs.tmuxPlugins; [
			catppuccin
			vim-tmux-navigator
		];
	};
}
