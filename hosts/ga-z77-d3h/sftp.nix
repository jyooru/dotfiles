{
  networking.firewall.interfaces = {
    "nebula0".allowedTCPPorts = [ 2201 ];
    "enp4s0".allowedTCPPorts = [ 2202 ];
  };

  containers = {
    "sftp-files-games-roms" = {
      autoStart = true;
      ephemeral = true;

      bindMounts."files" = {
        hostPath = "/home/joel/files/games/roms";
        mountPoint = "/srv";
        isReadOnly = true;
      };

      config = {
        services.openssh = {
          enable = true;
          listenAddresses = [{ addr = "0.0.0.0"; port = 2202; }];
          passwordAuthentication = false;
        };

        users.users.joel = {
          isNormalUser = true;
          openssh.authorizedKeys.keyFiles = [
            ../retropie/keys/ssh-pi.pub
            ../retropie/keys/ssh-root.pub
          ];
        };
      };
    };
  };
}
