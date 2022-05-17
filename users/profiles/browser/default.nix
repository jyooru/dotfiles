{ lib, pkgs, ... }:

with lib;

let
  theme = pkgs.min-firefox.outPath;
in

{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      # ipfs-companion
      # metamask
      # ublock-origin # shipped with librewolf
    ];

    profiles."profile" = {
      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;

        "signon.rememberSignons" = false;
      };
      userChrome = readFile (theme + "/userChrome.css");
      userContent = readFile (theme + "/userContent.css");
    };
  };

  home.file.".librewolf/profiles.ini".text = generators.toINI { } {
    General.StartWithLastProfile = 1;
    Profile0 = {
      Default = 1;
      IsRelative = 1;
      Name = "profile";
      Path = "../.mozilla/firefox/profile";
    };
  };
}
