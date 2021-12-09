{ config, lib, ... }:

with lib;

let
  cfg = config.modules.programs.bash;
in

{
  options.modules.programs.bash = {
    enable = mkEnableOption "Shell";
  };
  config = mkIf cfg.enable {
    home-manager.users.joel.programs.bash = {
      enable = true;
      bashrcExtra = ''
        export EDITOR="code --wait"
        export GIT_EDITOR="nano"

        # git functions
        ga () {
          # git add
          if [ $# -eq 0 ]; then
              git add .
          else
              git add "$@"
          fi
        }
        gc () {
          # git commit
          if [ $# -eq 0 ]; then
            git commit
          else
            git commit -m "$*"
          fi
        } 
        gbc () {
          # git branch and checkout
          git branch "$1"
          git checkout "$1"
        }
        gbu () {
          # git branch set upstream
          git branch "--set-upstream-to=origin/$1" "$1"
        }
        gbpd () {
          # git branch pull and delete
          branch=`git rev-parse --abbrev-ref HEAD`
          git checkout main
          git pull
          git branch -d $branch
        }

        # vscode function
        c () {
          if [ $# -eq 0 ]; then
            code .
            exit
          else
            code "$*"
          fi
        }
      '';
      shellAliases = {
        # lsd aliases
        l = "lsd";
        la = "lsd -A";
        ll = "lsd -Al";

        # directory aliases
        "~" = "cd ~";
        ".." = "cd ..";
        "-- -" = "cd -";

        alert = ''
          notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '''s/^s*[0-9]+s*//;s/[;&|]s*alert$//''')\""
        '';
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
  };
}
