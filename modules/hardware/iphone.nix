# https://gist.github.com/danbst/1aed84dd0f5fe465dfca9319c6e63df5
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.hardware.iphone;
in

{
  options.modules.hardware.iphone = {
    enable = mkEnableOption "USB Tethering and Filesystem support for iPhone";
    mountPath = mkOption {
      type = types.str;
      default = "/run/media/iphone";
      description = "Path to mount the connected iPhone.";
    };
    user = mkOption {
      type = types.str;
      description = "User to own the mount path.";
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libimobiledevice
      usbmuxd
      (writeScriptBin "iphone" ''
        sudo systemctl restart iphone \
         && ${pkgs.gnome2.libgnome}/bin/gnome-open ${cfg.mountPath}
      '')
    ];

    services.usbmuxd = { enable = true; user = cfg.user; };

    systemd.services.iphone = {
      preStart = "mkdir -p ${cfg.mountPath} && chown ${cfg.user} ${cfg.mountPath}";
      script = ''
        ${pkgs.libimobiledevice}/bin/idevicepair pair \
        && exec ${pkgs.ifuse}/bin/ifuse ${cfg.mountPath}
      '';
      serviceConfig = {
        PermissionsStartOnly = true;
        User = cfg.user;
        Type = "forking";
      };
    };
  };
}
