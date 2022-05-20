{ lib, pkgs, ... }:

with lib;

{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      # ipfs-companion
      # metamask # https://github.com/MetaMask/metamask-extension/issues/13163
      # ublock-origin # shipped with librewolf
    ];

    profiles."profile" =
      let duckduckgo = "https://duckduckgo.com/?kae=d&kbc=1&kap=-1&kao=-1&k1=-1&kax=-1&kav=1&kaq=-1&kak=-1&ks=m&kg=g&kaj=m&k7=1f1f1f&kj=1f1f1f&kt=FiraCode+Nerd+Font"; in
      {
        bookmarks = mapAttrs (keyword: url: { inherit keyword url; }) {
          # have to be imported manually in bookmarks manager -> import html
          # typing a keyword and pressing enter goes to that url

          c = "https://dash.cloudflare.com/";
          d = duckduckgo;
          o = "https://office.com/login"; # school
          r = "https://reddit.com/";
          y = "https://youtube.com/";

          ci = "https://hercules-ci.com/github/jyooru";
          gd = "https://github.com/jyooru/dotfiles";
          gdc = "https://hercules-ci.com/github/jyooru/dotfiles";
          gi = "https://github.com/notifications";
          gj = "https://github.com/jyooru";
          gn = "https://github.com/nixos/nixpkgs";
          gs = "https://github.com/stars";

          hm = "https://nix-community.github.io/home-manager/options.html";
          nm = "https://nixos.org/manual/nix/unstable/expressions/builtins.html";
          npm = "https://nixos.org/manual/nixpkgs/unstable/";
          nom = "https://nixos.org/manual/nixos/unstable/";
          nso = "https://search.nixos.org/options?channel=unstable";
          nsp = "https://search.nixos.org/packages?channel=unstable";

          # TODO: host domains (thinkpad-e580.joel.tokyo, syncthing.thinkpad-e580.joel.tokyo, ...)
          j = "https://joel.tokyo";
          jv = "https://vaultwarden.joel.tokyo";

          xno = "https://nanolooker.com/";
          xnot = "https://nanoticker.info/";
          xnomc = "https://raiblocksmc-play.com/";

          yggm = "http://[21e:e795:8e82:a9e2:ff48:952d:55f2:f0bb]/";
        };

        settings = {
          "browser.newtabpage.enabled" = false;
          "browser.startup.homepage" = duckduckgo;

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
