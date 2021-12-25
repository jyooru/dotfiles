{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.shell;
in

{
  options.modules.shell = {
    enable = mkEnableOption "Shell";
    enablePrompt = mkEnableOption "Shell prompt";
  };
  config = mkIf cfg.enable {
    users.extraUsers.joel.shell = pkgs.fish;

    home-manager.users.joel.programs = {
      fish = {
        enable = true;

        shellInit = ''
          set -gx EDITOR code --wait
          set -gx GIT_EDITOR nano

          set -g fish_greeting
          set -g fish_color_command normal --italics
          set -g fish_color_param normal
          set -g fish_color_valid_path brcyan --underline
        '';

        shellAliases = {
          "ls" = "lsd";
        };

        shellAbbrs = {
          c = "code";
          d = "docker";
          py = "python";
          pym = "python -m";
          o = "xdg-open";
          open = "xdg-open";

          a = "ip -br -c a";
          get-class = "xprop | grep WM_CLASS | awk '{print $4}'";
          temp = "watch -n 1 sensors";
          wifi-scan = "nmcli dev wifi list --rescan yes";

          l = "lsd";
          la = "lsd -A";
          ll = "lsd -Al";

          "-" = "cd -";

          g = "git";
          ga = "git add";
          gaa = "git add ."; # git add all
          gbu = "git branch --set-upstream-to=origin/";
          gb = "git branch";
          gbd = "git branch -d";
          gbD = "git branch -D";
          gbm = "git branch -m";
          gbpd = "git checkout main || git checkout master && git pull && git branch -d"; # git branch pull delete
          gc = "git commit";
          gca = "git commit --amend";
          gch = "git checkout";
          gcl = "git clone";
          gd = "git diff";
          gf = "git fetch";
          gi = "git init";
          gl = "git log --graph --oneline --decorate";
          glf = "git log --pretty=fuller";
          glo = "git log --pretty=oneline";
          gm = "git merge --no-ff";
          gp = "git push";
          gpl = "git pull";
          gps = "git push";
          gpsf = "git push --force";
          gr = "git remote";
          grb = "git rebase";
          grp = "git remote prune";
          grpo = "git remote prune origin";
          grs = "git reset --hard";
          gs = "git status";
          gst = "git stash";
          gstp = "git stash pop";
          gu = "git reset --soft HEAD^"; # git undo

          n = "nix";
          nb = "nix build";
          nbb = "nix build .";
          nbn = "nix build nixpkgs#";
          nd = "nix develop";
          nf = "nix flake";
          nfc = "nix flake check";
          nfl = "nix flake lock";
          nfu = "nix flake update";
          nh = "nix-hash";
          nhb = "nix-hash --type sha256 --to-base32";
          np = "nix-prefetch-url";
          nr = "nix run";
          nrr = "nix run .";
          ns = "nix shell nixpkgs#";

          no = "nixos-rebuild";
          nos = "sudo nixos-rebuild switch";
          nosd = "sudo nixos-rebuild switch && sudo deploy";
          nob = "nixos-rebuild build";

          nff = "nixpkgs-fmt";
          nfff = "nixpkgs-fmt .";
          npr = "nixpkgs-review pr";
          nprp = "nixpkgs-review post-result";
        };
      };

      starship = mkIf cfg.enablePrompt {
        enable = true;
        settings = {
          aws = { symbol = "  "; };
          conda = { symbol = " "; };
          dart = { symbol = " "; };
          directory = { read_only = " "; };
          docker_context = { symbol = " "; };
          elixir = { symbol = " "; };
          elm = { symbol = " "; };
          git_branch = { symbol = " "; };
          golang = { symbol = " "; };
          hg_branch = { symbol = " "; };
          java = { symbol = " "; };
          julia = { symbol = " "; };
          memory_usage = { symbol = " "; };
          nim = { symbol = " "; };
          nix_shell = { symbol = " "; };
          package = { symbol = " "; };
          perl = { symbol = " "; };
          php = { symbol = " "; };
          python = { symbol = " "; };
          ruby = { symbol = " "; };
          rust = { symbol = " "; };
          scala = { symbol = " "; };
          shlvl = { symbol = " "; };
          swift = { symbol = "ﯣ "; };
        };
      };

      zoxide.enable = true;
    };
  };
}
