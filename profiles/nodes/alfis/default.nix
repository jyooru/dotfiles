with builtins;

let
  # https://github.com/Revertron/Alfis/blob/master/src/blockchain/data/zones.txt
  alfisZones = [
    "anon"
    "btn"
    "conf"
    "index"
    "merch"
    "mirror"
    "mob"
    "screen"
    "srv"
    "ygg"
  ];
  forwardingRules = concatStringsSep "\n" (map (zone: "${zone} 127.0.0.1:5354") alfisZones);
in

{
  services = {
    alfis = {
      enable = true;

      settings = {
        net.yggdrasil_only = true;

        dns = {
          listen = "127.0.0.1:5354";

          # dnscrypt-proxy2 forwards to alfis
          forwarders = [ ];
          bootstraps = [ ];
        };
      };
    };

    dnscrypt-proxy2.settings.forwarding_rules = toFile "forwarding-rules.txt" forwardingRules;
  };
}
