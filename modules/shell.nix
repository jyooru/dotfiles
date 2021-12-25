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
          export EDITOR="code --wait"
          export GIT_EDITOR="nano"

          # git functions
          function ga
            # git add
            if [ (count $argv) -eq 0 ]
                git add .
            else
                git add "$argv"
            end
          end

          function gc
            # git commit
            if [ (count $argv) -eq 0 ]
              git commit
            else
              git commit -m "$argv"
            end
          end

          function gbc
            # git branch and checkout
            git branch "$1"
            git checkout "$1"
          end

          function gbu
            # git branch set upstream
            git branch "--set-upstream-to=origin/$1" "$1"
          end

          function gbpd
            # git branch pull and delete
            branch=`git rev-parse --abbrev-ref HEAD`
            git checkout main
            git pull
            git branch -d $branch
          end

          # vscode function
          function c
            if [ (count $argv) -eq 0 ]
              code .
              exit
            else
              code "$argv"
            end
          end
        '';
        shellAliases = {
          # lsd aliases
          l = "lsd";
          la = "lsd -A";
          ll = "lsd -Al";

          # directory aliases
          ".." = "cd ..";
          "--" = "cd -";

          # alert = ''
          #   notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '''s/^s*[0-9]+s*//;s/[;&|]s*alert$//''')\""
          # '';
          temp = "watch -n 1 sensors";

          # program shortcuts
          d = "docker";
          db = "docker build .";
          dbt = "docker build . --tag";
          de = "docker exec";
          di = "docker insepct";
          dl = "docker logs";
          dlf = "docker logs -f";
          dr = "docker run";
          drm = "docker rm";
          drs = "docker restart";
          ds = "docker start";
          dt = "docker tag";
          dp = "docker push";
          dpl = "docker pull";
          dps = "docker ps";
          dst = "docker stop";
          dstf = "docker stop --time 0";
          dstt = "docker stop --time";
          dsu = "docker service update --force";
          py = "python";
          pyd = "pyenv && pipir && pipf && deactivate && rm -rf env";
          pyenv =
            "pip install virtualenv && py -m virtualenv env && source env/bin/activate";
          pym = "python -m";
          o = "xdg-open";
          open = "xdg-open";
          g = "git";
          gb = "git branch";
          gbd = "git branch -d";
          gbD = "git branch -D";
          gbm = "git branch -m";
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
          gp = "git pull; git push";
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
          gu = "git reset --soft HEAD^";
          wifi-scan = "nmcli dev wifi list --rescan yes";
          jks = "bundle exec jekyll serve --livereload";
          jkb = "bundle exec jekyll build";
          pipf = "pip freeze > requirements.txt";
          pipi = "pip install";
          pipir = "pip install -r requirements.txt";
          pipih =
            "pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org";
          pipl = "pip list";
          pipu = "pip uninstall";

          a = "ip -br -c a";
          nix-hash-sha256 = "nix-hash --type sha256 --to-base32";

          get-class = "xprop | grep WM_CLASS | awk '{print $4}'";
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
