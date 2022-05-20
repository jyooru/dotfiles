{ lib, pkgs, ... }:

with lib;

let
  theme = with pkgs; stdenv.mkDerivation {
    name = "simplefox";

    src = fetchFromGitHub {
      owner = "migueravila";
      repo = "SimpleFox";
      rev = "a4c1ec7d2af121047f09da4a572960e032ca29a6";
      sha256 = "0mczxv25l4hc00hgmsc21ln4x9dblaf55p7ivgrbqqcrfdg0pll8";
    };

    patches = [
      ./colors.patch
    ];

    installPhase = ''
      cp -r chrome "$out"
    '';
  };
in

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

    profiles."profile" = {
      bookmarks = {
        # %s doesn't seem to work?
        github-dotfiles = {
          keyword = "gd";
          url = "https://github.com/jyooru/dotfiles";
        };
        github-nixpkgs = {
          keyword = "gn";
          url = "https://github.com/nixos/nixpkgs";
        };
        home-manager = {
          keyword = "hm";
          url = "https://nix-community.github.io/home-manager/options.html";
        };
        nix-search-options = {
          keyword = "nso";
          url = "https://search.nixos.org/options?channel=unstable&query=";
        };
        nix-search-packages = {
          keyword = "nsp";
          url = "https://search.nixos.org/packages?channel=unstable&query=";
        };
      };

      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.uiCustomization.state" = readFile ./ui.json;
        "browser.toolbars.bookmarks.visibility" = "never";
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
