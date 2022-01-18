{
  programs.vscode.keybindings = [
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
}
