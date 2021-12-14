{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.browser;

  theme = "${pkgs.min-firefox}";
in

{
  options.modules.browser = {
    enable = mkEnableOption "Browser";
  };
  config = mkIf cfg.enable {
    home-manager.users.joel.programs.firefox = {
      enable = true;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        buster-captcha-solver
        darkreader
        duckduckgo-privacy-essentials # https://duckduckgo.com/?kav=1&k1=-1&kaj=m&k7=1f1f1f&kae=d&kj=1f1f1f&k21=303030
        https-everywhere
        ipfs-companion
        metamask
      ];

      profiles."profile" = {
        settings = {
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.all" = true;
          "svg.context-properties.content.enabled" = true;
        };
        userChrome = builtins.readFile (theme + "/userChrome.css");
        userContent = builtins.readFile (theme + "/userContent.css");
      };
    };
  };
}
