{ lib, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with lib; collect isDerivation (import ../../../packages { inherit pkgs; }).vscode-extensions;
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
      {
        # remove `ctrl+f` keybind in terminal
        key = "ctrl+f";
        command = "-workbench.action.terminal.focusFind";
        when = "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
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
      "workbench.statusBar.visible" = false;
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
      "workbench.startupEditor" = "none";

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
        "result" = "dist";
        "dotfiles" = "config";
        "nixpkgs" = "packages";
        "pkgs" = "packages";
        "overlays" = "queue";
        "workflows" = "ci";
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
}
