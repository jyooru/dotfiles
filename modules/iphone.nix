# https://gist.github.com/danbst/1aed84dd0f5fe465dfca9319c6e63df5
{ config, pkgs, lib, ... }:
let
  cfg = config.modules.iphone;
in
{
  options.modules.iphone = {
    enable = lib.mkOption { default = false; };
    directory = lib.mkOption { default = "/run/media/iPhone"; };
    user = lib.mkOption { };
  };
  config = lib.mkIf cfg.enable {
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
