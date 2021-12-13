{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.browser;

  theme = "${pkgs.firefox-themes}/Simplify Darkish/Simplify Gray/";
in

{
  options.modules.browser = {
    enable = mkEnableOption "Browser";
  };
  config = mkIf cfg.enable {
    home-manager.users.joel.programs.firefox = {
      enable = true;

      profiles."profile" = {
        settings = {
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
