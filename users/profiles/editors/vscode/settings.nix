let
  userSettings = rec {
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
      "**/.mypy_cache" = true;
      "**/.pytest_cache" = true;
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
    "ev3devBrowser.additionalDevices" = [{
      "name" = "j";
      "ipAddress" = "192.168.1.3";
    }];
    "gitlens.currentLine.enabled" = false;
    "redhat.telemetry.enabled" = false;

    # languages
    "workbench.editorAssociations" = { "*.ipynb" = "jupyter-notebook"; };
    "[html]"."editor.defaultFormatter" = "vscode.html-language-features";
    "html.format.endWithNewline" = true;
    "html.format.indentInnerHtml" = true;
    "html.format.maxPreserveNewLines" = 1;
    "html.format.templating" = true;
    "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[json]"."editor.defaultFormatter" = "vscode.json-language-features";
    "[jsonc]" = userSettings."[json]";
    "[markdown]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.wordWrap" = "on";
    };
    "[python]"."editor.tabSize" = 4;
    "python.formatting.provider" = "black";
    "python.linting.flake8Enabled" = true;
    "python.linting.flake8Args" = [ "--max-line-length=88" ];
    "python.testing.pytestEnabled" = true;
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "typescript.extension.sortImports.sortOnSave" = true;
    "[typescriptreact]" = userSettings."[typescript]";
    "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
  };
in

{
  programs.vscode = { inherit userSettings; };
}
