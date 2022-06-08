{ lib, pkgs, ... }:

with lib;

let
  bookmarks = (import ./bookmarks.nix);
in

{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      ipfs-companion
      # metamask # https://github.com/MetaMask/metamask-extension/issues/13163
      # ublock-origin # shipped with librewolf
    ];

    profiles."profile" = {
      # have to be imported manually in bookmarks manager -> import html
      # typing a keyword and pressing enter goes to that url
      bookmarks = mapAttrs (keyword: url: { inherit keyword url; }) bookmarks;

      settings = {
        "browser.newtabpage.enabled" = false;
        "browser.startup.homepage" = bookmarks.d;

        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.uiCustomization.state" = readFile ./ui.json;
        "browser.toolbars.bookmarks.visibility" = "never";
      };

      userChrome = readFile (pkgs.callPackage ./cascade.nix { });
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
