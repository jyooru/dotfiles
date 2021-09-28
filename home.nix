{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "joel";
  home.homeDirectory = "/home/joel";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
        export EDITOR="code --wait"
        export GIT_EDITOR="nano"
      '';
      shellAliases = {
        # ls aliases
        ll = "ls -alF";
        la = "ls -A";
        l = "ls -CF";

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
      };
    };

    git = {
      enable = true;
      signing.key = "33CA5F24";
      signing.signByDefault = true;
      userEmail = "joel@joel.tokyo";
      userName = "Joel";
      includes = [{
        contents = {
          init = { defaultBranch = "main"; };
          push = { default = "current"; };
          pull = { rebase = true; };
        };
      }];
    };
  };
}
