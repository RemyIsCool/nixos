{ ... }:
{
	programs.wofi = {
		enable = true;
		settings = {
			no_actions = true;
			height = "41%";
			width = "35%";
		};
		style = /* css */ ''
			#window {
				border: 2px solid #cba6f7;
			}
			
			#outer-box {
				padding: 20px;
			}
			
			#input {
				background: none;
				padding: 5px 10px;
				border: 2px solid #7f849c;
				border-radius: 0;
				color: #cdd6f4;
			}
			
			#entry {
				background: none;
				padding: 0;
				padding-top: 16px;
				outline: none;
			}
			
			.entry {
				padding: 12px 18px;
				border: 2px solid #45475a;
				border-radius: 0;
				color: #cdd6f4;
			}
			
			.entry#selected {
				border: 2px solid #cba6f7;
			}
		'';
	};	
}
