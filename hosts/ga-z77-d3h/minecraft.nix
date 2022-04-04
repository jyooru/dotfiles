{ pkgs, ... }:
{
  networking.firewall.interfaces."enp4s0".allowedTCPPorts = [ 25565 ];
  services.minecraft-server = {
    enable = true;
    declarative = true;
    eula = true;
    package = pkgs.minecraftServers.purpur_1_18_2;
    serverProperties.motd = "\\u00A7b                    \\u00A7lplay.joel.tokyo\\u00A7r\\n\\u00A7c                          [1.18.2]";
  };
}
