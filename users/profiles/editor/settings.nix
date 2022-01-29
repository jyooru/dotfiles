{
  programs.vscode.userSettings = {
    # theme
    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = true;
    "editor.fontFamily" = "FiraCode Nerd Font";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 14;
    "editor.minimap.enabled" = false;
    "material-icon-theme.folders.associations" = {
      # https://github.com/PKief/vscode-material-icon-theme#folder-icons

      # ~
      "media" = "video";
      # ~/code
      "clones" = "download";
      "repos" = "src";
      "workspaces" = "resource";
      # ~/code/clones
      "view" = "review";
      # ~/code/repos
      "gh" = "github";
      "gl" = "gitlab";
      "local" = "client";
      # ~/code/repos/gh/**/.github
      "workflows" = "ci";
      # ~/code/repos/gh/jyooru
      "dotfiles" = "config";
      "nixpkgs" = "packages";
      # ~/code/repos/gh/jyooru/dotfiles
      "hosts" = "client";
      "overlays" = "queue";
      "profiles" = "config";
      "users" = "home";
      # ~/code/repos/gh/jyooru/dotfiles/profiles
      "hardware" = "core";
      # ~/code/repos/gh/jyooru/nixpkgs
      "pkgs" = "packages";
      "result" = "dist";
    };
    "workbench.activityBar.visible" = false;
    "workbench.colorTheme" = "Min Dark";
    "workbench.editor.showTabs" = false;
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.statusBar.visible" = false;
    "window.menuBarVisibility" = "hidden";

    # functionality
    "diffEditor.renderSideBySide" = false;
    "editor.formatOnType" = true;
    "editor.formatOnSave" = true;
    "editor.linkedEditing" = true;
    "editor.insertSpaces" = true;
    "editor.tabSize" = 2;
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
    "files.associations" = { "*.liquid" = "html"; };
    "files.exclude" = {
      "**/.stfolder" = true;
      "**/__pycache__" = true;
    };
    "git.autofetch" = true;
    "git.confirmSync" = false;
    "git.fetchOnPull" = true;
    "git.inputValidationLength" = 2147483647;
    "git.inputValidationSubjectLength" = 2147483647;
    "git.pruneOnFetch" = true;
    "workbench.startupEditor" = "none";

    # extensions
    "gitlens.currentLine.enabled" = false;
    "redhat.telemetry.enabled" = false;

    # languages
    "workbench.editorAssociations" = { "*.ipynb" = "jupyter-notebook"; };
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[json]"."editor.defaultFormatter" = "vscode.json-language-features";
    "[jsonc]"."editor.defaultFormatter" = "vscode.json-language-features";
    "[markdown]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.wordWrap" = "on";
    };
    "[python]"."editor.tabSize" = 4;
    "python.defaultInterpreterPath" = "/usr/bin/python";
    "python.formatting.provider" = "black";
    "python.linting.flake8Enabled" = true;
    "python.linting.flake8Args" = [ "--max-line-length=88" ];
    "python.pythonPath" = "/usr/bin/python";
    "python.showStartPage" = false;
    "python.testing.pytestEnabled" = true;
    "rust-client.autoStartRls" = false;
    "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
  };
}
