{ config, pkgs, ... }:

{
  imports = [ ./bspwm.nix ];

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

        nixs = "sudo nixos-rebuild switch && home-manager switch";
      };
    };

    starship = {
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

    vscode = {
      enable = true;
      extensions = [
        # pkgs.vscode-extensions.ahmadalli.vscode-nginx-conf
        pkgs.vscode-extensions.eamodio.gitlens
        # pkgs.vscode-extensions.enkia.tokyo-night
        pkgs.vscode-extensions.esbenp.prettier-vscode
        # pkgs.vscode-extensions.GitHub.github-vscode-theme
        # pkgs.vscode-extensions.GitHub.remotehub
        # pkgs.vscode-extensions.GitHub.vscode-pull-request-github
        # pkgs.vscode-extensions.icrawl.discord-vscode
        # pkgs.vscode-extensions.miguelsolorio.min-theme
        pkgs.vscode-extensions.ms-azuretools.vscode-docker
        pkgs.vscode-extensions.ms-python.python
        pkgs.vscode-extensions.ms-python.vscode-pylance
        pkgs.vscode-extensions.ms-toolsai.jupyter
        # pkgs.vscode-extensions.ms-vscode-remote.remote-containers
        # pkgs.vscode-extensions.ms-vscode.live-server
        pkgs.vscode-extensions.naumovs.color-highlight
        # pkgs.vscode-extensions.PeterStaev.lego-spikeprime-mindstorms-vscode
        # pkgs.vscode-extensions.PKief.material-icon-theme
        # pkgs.vscode-extensions.pranaygp.vscode-css-peek
        # pkgs.vscode-extensions.raynigon.nginx-formatter
        # pkgs.vscode-extensions.redhat.vscode-commons
        # pkgs.vscode-extensions.redhat.vscode-xml
        pkgs.vscode-extensions.redhat.vscode-yaml
        # pkgs.vscode-extensions.rust-lang.rust
        pkgs.vscode-extensions.timonwong.shellcheck
        pkgs.vscode-extensions.yzhang.markdown-all-in-one
      ];
      keybindings = [
        {
          key = "ctrl+alt+b";
          command = "workbench.action.toggleActivityBarVisibility";
        }
        {
          key = "ctrl+alt+";
          command = "workbench.action.openSettingsJson";
        }
        {
          key = "shift+alt+d";
          command = "workbench.view.extension.dockerView";
        }
        {
          key = "shift+alt+m";
          command = "editor.action.toggleMinimap";
        }
        {
          key = "ctrl+shift+g l";
          command = "workbench.view.extension.gitlens";
        }
        {
          key = "ctrl+shift+g h";
          command = "-gitlens.showQuickFileHistory";
          when = "!gitlens:disabled && config.gitlens.keymap == 'chorded'";
        }
        {
          key = "ctrl+shift+g ctrl+h";
          command = "gitlens.showQuickFileHistory";
          when = "!gitlens:disabled && config.gitlens.keymap == 'chorded'";
        }
        {
          key = "shift+alt+r l";
          command = "remote-containers.reopenLocally";
        }
        {
          key = "shift+alt+r r";
          command = "remote-containers.reopenInContainer";
        }
        {
          key = "shift+alt+r w";
          command = "remote-containers.openWorkspace";
        }
        {
          key = "shift+alt+r n";
          command = "remote-containers.newContainer";
        }
        {
          key = "shift+alt+r shift+r";
          command = "remote-containers.rebuildContainer";
        }
      ];
      userSettings = {
        # theme
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = true;
        "editor.fontFamily" = "FiraCode Nerd Font";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        "editor.minimap.enabled" = false;
        "workbench.activityBar.visible" = false;
        "workbench.colorTheme" = "Min Dark";
        "workbench.editor.showTabs" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "window.menuBarVisibility" = "toggle"; # alt shows menu

        # functionality
        "diffEditor.renderSideBySide" = false;
        "editor.formatOnType" = true;
        "editor.formatOnSave" = true;
        "editor.linkedEditing" = true;
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "editor.inlineSuggest.enabled" = true;
        "git.confirmSync" = false;
        "git.inputValidationLength" = 2147483647;
        "git.inputValidationSubjectLength" = 2147483647;
        "remote.containers.dotfiles.repository" =
          "https://github.com/jyooru/dotfiles.git";
        "workbench.startupEditor" = "newUntitledFile";

        # extensions
        "gitlens.hovers.currentLine.over" = "line";
        "gitlens.currentLine.enabled" = false;
        "redhat.telemetry.enabled" = false;

        # languages
        "workbench.editorAssociations" = { "*.ipynb" = "jupyter-notebook"; };
        #html
        "[html]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        # js
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        # json
        "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[jsonc]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        # md
        "[markdown]" = {
          "editor.wordWrap" = "on";
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        # py
        "[python]" = { "editor.tabSize" = 4; };
        "python.defaultInterpreterPath" = "/usr/bin/python";
        "python.formatting.provider" = "black";
        "python.linting.flake8Enabled" = true;
        "python.linting.flake8Args" = [ "--max-line-length=88" ];
        "python.pythonPath" = "/usr/bin/python";
        "python.showStartPage" = false;
        "python.testing.pytestEnabled" = true;
        # rs
        "rust-client.autoStartRls" = false;
        # sh
        "shellcheck.customArgs" = [ "-s bash" "-x" ];
        # nginx.conf
        "[nginx]" = { "editor.defaultFormatter" = "raynigon.nginx-formatter"; };
        # yaml
        "[yaml]" = { "editor.defaultFormatter" = "redhat.vscode-yaml"; };
      };
    };
  };
}
