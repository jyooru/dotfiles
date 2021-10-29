{ config, pkgs, lib, ... }:
let
  cfg = config.modules.programs.vscode;
in
{
  options.modules.programs.vscode = {
    enable = lib.mkEnableOption "Code editor";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.joel.programs.vscode = {
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
        pkgs.vscode-extensions.jnoortheen.nix-ide
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
        "files.exclude" = { "**/.stfolder" = true; "**/__pycache__" = true; };
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
        "material-icon-theme.folders.associations" = {
          "clones" = "download";
          "repos" = "src";
          "gh" = "github";
          "gl" = "gitlab";
          "local" = "vm";
          "starred" = "import";
          "workspaces" = "resources";
          "view" = "review";
          "media" = "video";
        };

        # languages
        "workbench.editorAssociations" = { "*.ipynb" = "jupyter-notebook"; };
        #html
        "[html]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        # js
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        # json
        "[json]" = { "editor.defaultFormatter" = "vscode.json-language-features"; };
        "[jsonc]" = { "editor.defaultFormatter" = "vscode.json-language-features"; };
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
