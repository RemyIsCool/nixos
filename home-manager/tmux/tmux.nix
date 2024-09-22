{ ... }:
{
	programs.tmux = {
		enable = true;
		terminal = "screen-256color";
		extraConfig = /*tmux*/ ''
			set -ga terminal-overrides ",xterm-256color:Tc"
			set -g terminal-features "xterm-256color:Tc"
		'';
	};
}
