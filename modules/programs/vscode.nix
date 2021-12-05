{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.programs.vscode;
in

{
  options.modules.programs.vscode = {
    enable = mkEnableOption "Code editor";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vscode ];

    home-manager.users.joel.programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        # ahmadalli.vscode-nginx-conf
        eamodio.gitlens
        # enkia.tokyo-night
        esbenp.prettier-vscode
        # GitHub.github-vscode-theme
        # GitHub.remotehub
        # GitHub.vscode-pull-request-github
        # icrawl.discord-vscode
        jnoortheen.nix-ide
        # miguelsolorio.min-theme
        ms-azuretools.vscode-docker
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        # ms-vscode-remote.remote-containers
        # ms-vscode.live-server
        naumovs.color-highlight
        # PeterStaev.lego-spikeprime-mindstorms-vscode
        # PKief.material-icon-theme
        # pranaygp.vscode-css-peek
        # raynigon.nginx-formatter
        # redhat.vscode-commons
        # redhat.vscode-xml
        redhat.vscode-yaml
        # rust-lang.rust
        timonwong.shellcheck
        yzhang.markdown-all-in-one
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
        "files.associations" = { "*.liquid" = "html"; };
        "files.exclude" = { "**/.stfolder" = true; "**/__pycache__" = true; };
        "git.confirmSync" = false;
        "git.autofetch" = true;
        "git.fetchOnPull" = true;
        "git.inputValidationLength" = 2147483647;
        "git.inputValidationSubjectLength" = 2147483647;
        "git.pruneOnFetch" = true;
        "remote.containers.dotfiles.repository" =
          "https://github.com/jyooru/dotfiles.git";
        "workbench.startupEditor" = "newUntitledFile";

        # extensions
        "gitlens.hovers.currentLine.over" = "line";
        "gitlens.currentLine.enabled" = false;
        "redhat.telemetry.enabled" = false;
        "material-icon-theme.folders.associations" = {
          # https://github.com/PKief/vscode-material-icon-theme#file-icons
          "clones" = "download";
          "repos" = "src";
          "gh" = "github";
          "gl" = "gitlab";
          "local" = "client";
          "starred" = "import";
          "workspaces" = "resources";
          "view" = "review";
          "media" = "video";
          "hosts" = "client";
          "hardware" = "core";
          "programs" = "app";
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
