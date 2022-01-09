{ pkgs, ... }:
{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    scrcpy # android screen mirroring tool
    heimdall # samsung device custom recovery installer
  ];
}
