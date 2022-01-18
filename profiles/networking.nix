{
  networking = rec {
    domain = "dev.joel.tokyo";
    firewall.enable = true;
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    };
    search = [ domain ];
  };
}
