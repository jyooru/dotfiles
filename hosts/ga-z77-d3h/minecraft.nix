{ pkgs, ... }:
{
  networking.firewall.extraCommands =
    let
      command = "ip6tables -A nixos-fw -p tcp --dport 25565 -j nixos-fw-accept -i ygg0";
    in
    ''
      ${command} --src 202:2e27:ab34:3bce:b238:2b1f:4c36:3780
      ${command} --src 201:a31e:699c:23e4:8088:719f:ae26:61a7
    '';

  services.minecraft-server = {
    enable = true;

    eula = true;
    package = pkgs.minecraftServers.purpur_1_18_2;

    declarative = true;
    serverProperties = {
      motd = "\\u00A7fSelect all squares with \\u00A7lstreet signs\\n\\u00A7rIf there are none, click skip";
      online-mode = false;
    };
  };
}
