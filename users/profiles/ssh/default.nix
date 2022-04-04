{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "0 pi" = {
        hostname = "raspberrypi.local";
        user = "pi";
      };
      "l laptop thinkpad-e580" = {
        hostname = "thinkpad-e580.joel.tokyo";
      };
      "1 portege-r700-a" = {
        hostname = "portege-r700-a.joel.tokyo";
      };
      # "2 portege-r700-b" = {
      #   hostname = "portege-r700-b.joel.tokyo";
      # };
      "3 portege-z930" = {
        hostname = "portege-z930.joel.tokyo";
      };
      "4 ga-z77-d3h" = {
        hostname = "ga-z77-d3h.joel.tokyo";
      };
      "r retropie" = {
        hostname = "192.168.0.21";
        user = "pi";
      };
    };
  };
}
