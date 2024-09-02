{ inputs, ... }:
{
	programs.firefox = {
		enable = true;
		profiles.remy = {
			userChrome = /* css */ ''
				:root {
  					--tab-border-radius: 0 !important;
  					--toolbarbutton-border-radius: 0 !important;
				}

				#urlbar-input {
					margin-left: 0.25rem !important;
				}
				
				#alltabs-button, .titlebar-buttonbox-container, #star-button-box, #tracking-protection-icon-container, #identity-box {
					display: none;
				}
				
				@media (min-width: 1000px) {
					#navigator-toolbox {
				    	flex-direction: row-reverse;
				  	}
				
				  	#titlebar {
						flex: 1;
				  	}
				
				  	#nav-bar {
				    	background: none !important;
				  	}
				}
			'';

			settings = {
				"browser.aboutConfig.showWarning" = false;
				"browser.contentblocking.category" = "strict";
				"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
				"browser.newtabpage.activity-stream.feeds.topsites" = false;
				"browser.safebrowsing.malware.enabled" = false;
				"browser.safebrowsing.phishing.enabled" = false;
				"browser.toolbars.bookmarks.visibility" = "never";
				"browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["ublock0_raymondhill_net-browser-action","sponsorblocker_ajay_app-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","urlbar-container","customizableui-special-spring2","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","sponsorblocker_ajay_app-browser-action","ublock0_raymondhill_net-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","unified-extensions-area"],"currentVersion":20,"newElementCount":3}'';
				"browser.urlbar.placeholderName" = "DuckDuckGo";
				"browser.urlbar.placeholderName.private" = "DuckDuckGo";
				"datareporting.healthreport.uploadEnabled" = false;
				"dom.security.https_only_mode" = true;
				"dom.security.https_only_mode_ever_enabled" = true;
				"font.name.monospace.x-western" = "JetBrains Mono";
				"font.name.sans-serif.x-western" = "Inter";
				"signon.rememberSignons" = false;
				"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
			};

			extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
				ublock-origin
				sponsorblock
				return-youtube-dislikes
				firefox-color
				tabliss
				stylus
			];

			search = {
				force = true;
				default = "DuckDuckGo";
			};
		};
	};
}
