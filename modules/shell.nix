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
          set -g EDITOR code --wait
          set -g GIT_EDITOR nano

          set -g fish_greeting
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
          nix-hash-sha256 = "nix-hash --type sha256 --to-base32";
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
    };
  };
}
