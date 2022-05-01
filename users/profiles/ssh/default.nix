{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "0 pi" = {
        hostname = "raspberrypi.local";
        user = "pi";
      };
      "l" = {
        hostname = "thinkpad-e580.joel.tokyo";
      };
      "1" = {
        hostname = "portege-r700-a.joel.tokyo";
      };
      # "2" = {
      #   hostname = "portege-r700-b.joel.tokyo";
      # };
      "3" = {
        hostname = "portege-z930.joel.tokyo";
      };
      "4" = {
        hostname = "ga-z77-d3h.joel.tokyo";
      };
      "r retropie" = {
        hostname = "192.168.0.21";
        user = "pi";
      };
    };
  };
}
