{
  programs.vscode.userSettings = {
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
