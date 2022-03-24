{
  programs.vscode.userSettings = {
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
    "[html]"."editor.defaultFormatter" = "vscode.html-language-features";
    "html.format.endWithNewline" = true;
    "html.format.indentInnerHtml" = true;
    "html.format.maxPreserveNewLines" = 1;
    "html.format.templating" = true;
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
    "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
  };
}
