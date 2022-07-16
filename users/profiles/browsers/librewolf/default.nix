{ lib, pkgs, ... }:

with lib;

let
  hosts = {
    "l" = "thinkpad-e580";
    "1" = "portege-r700-a";
    "2" = "portege-r700-b";
    "3" = "portege-z930";
    "4" = "ga-z77-d3h";
  };
  subjects = [ "business" "english" "it" "japanese" "maths" "science" ];

  bookmarks = foldl' (x: y: x // y) { } ([
    (import ./bookmarks.nix)
  ] ++ (attrValues
    (mapAttrs
      (keyword: hostname:
        let hd = "${hostname}.joel.tokyo"; in
        {
          ${keyword} = "https://${hd}";
          "${keyword}f" = "https://ipfs.${hd}";
          "${keyword}s" = "https://syncthing.${hd}";
        })
      hosts)
  ) ++ (map
    (subject:
      let s = substring 0 1 subject; in
      {
        "s${s}" = "file:///home/joel/school/${subject}/";
        "s${s}x" = "file:///home/joel/school/${subject}/textbook.pdf";
        "s${s}e" = "file:///home/joel/school/${subject}/exercises.pdf";
        "s${s}a" = "file:///home/joel/school/${subject}/assessment/";
        "s${s}at" = "file:///home/joel/school/${subject}/assessment/task.pdf";
      })
    subjects))
  ;
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
