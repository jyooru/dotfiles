let
  listen = "127.0.0.1:5354";
in

with builtins;

{
  services = {
    alfis = {
      enable = true;

      settings = {
        net.yggdrasil_only = true;

        dns = {
          inherit listen;

          # dnscrypt-proxy2 forwards to alfis
          forwarders = [ ];
          bootstraps = [ ];
        };
      };
    };

    dnscrypt-proxy2.settings.forwarding_rules = toFile "forwarding-rules.txt"
      (concatStringsSep
        "\n"
        (map (zone: "${zone} ${listen}") (import ./zones.nix))
      );
  };
}
