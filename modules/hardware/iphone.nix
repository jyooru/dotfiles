# https://gist.github.com/danbst/1aed84dd0f5fe465dfca9319c6e63df5
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.hardware.iphone;
in

{
  options.modules.hardware.iphone = {
    enable = mkEnableOption "USB Tethering and Filesystem support for iPhone";
    directory = mkOption { default = "/run/media/iPhone"; };
    user = mkOption { };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.libimobiledevice
      pkgs.usbmuxd
      (pkgs.writeScriptBin "iphone" ''
        sudo systemctl restart iphone \
         && ${pkgs.gnome2.libgnome}/bin/gnome-open ${cfg.directory}
      '')
    ];
    services.usbmuxd.enable = true;
    services.usbmuxd.user = cfg.user;

    systemd.services.iphone = {
      preStart = "mkdir -p ${cfg.directory}; chown ${cfg.user} ${cfg.directory}";
      script = ''
        ${pkgs.libimobiledevice}/bin/idevicepair pair \
        && exec ${pkgs.ifuse}/bin/ifuse ${cfg.directory}
      '';
      serviceConfig = {
        PermissionsStartOnly = true;
        User = cfg.user;
        Type = "forking";
      };
    };
  };
}
