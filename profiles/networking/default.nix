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
  networking = rec {
    domain = "joel.tokyo";
    firewall.enable = true;
    networkmanager = {
      enable = true;
      insertNameservers = [ "127.0.0.1" "::1" ];
    };
    search = [ domain ];
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      forwarding_rules = toFile "forwarding-rules.txt" forwardingRules;
      listen_addresses = [ "[::]:53" ];
      server_names = [ "cloudflare" "cloudflare-ipv6" ];
    };
    upstreamDefaults = true;
  };
}
