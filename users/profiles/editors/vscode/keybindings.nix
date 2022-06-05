{
  programs.vscode.keybindings = [
    {
      key = "ctrl+alt+,";
      command = "workbench.action.openSettingsJson";
    }
    {
      # pass `ctrl+f` to terminal instead of bringing up find
      key = "ctrl+f";
      command = "-workbench.action.terminal.focusFind";
      when = "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
    }
  ];
}
