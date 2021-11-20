{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "playerctl-status" (builtins.readFile ./playerctl-status.sh))
  ];
}
