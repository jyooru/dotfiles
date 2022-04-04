{
  networking.firewall.interfaces."enp4s0".allowedTCPPorts = [ 25565 ];
  virtualisation.oci-containers.containers."minecraft" = {
    image = "itzg/minecraft-server";
    ports = [ "25565:25565" ];
    environment = {
      EULA = "true";
      TYPE = "purpur";
      OVERRIDE_SERVER_PROPERTIES = "true";
      MOTD = "\\u00A7b                    \\u00A7lplay.joel.tokyo\\u00A7r\\n\\u00A7c                          [1.18.1]";
      MEMORY = "4G";
      ENABLE_ROLLING_LOGS = "true";
      DIFFICULTY = "hard";
    };
    extraOptions = [ "--tty" ];
    volumes = [
      "/home/joel/node/data/minecraft:/data"
    ];
  };
}
