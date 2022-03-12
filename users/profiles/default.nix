{ utils }:

utils.lib.exportModules [
  ./browser
  ./common
  ./compositor
  ./editor
  ./file-manager
  ./git
  ./launcher
  ./notification-daemon
  ./packages/apps.nix
  ./packages/code.nix
  ./packages/tools.nix
  ./shell
  ./ssh
  ./terminal-emulator
  ./window-manager
]
