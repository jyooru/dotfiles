{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "0 pi" = {
        hostname = "raspberrypi.local";
        user = "pi";
      };
      "l laptop thinkpad-e580" = {
        hostname = "thinkpad-e580.dev.joel.tokyo";
      };
      "1 portege-r700-a" = {
        hostname = "portege-r700-a.dev.joel.tokyo";
      };
      "2 portege-r700-b" = {
        hostname = "portege-r700-b.dev.joel.tokyo";
      };
      "3 portege-z930" = {
        hostname = "portege-z930.dev.joel.tokyo";
      };
      "4 ga-z77-d3h" = {
        hostname = "ga-z77-d3h.dev.joel.tokyo";
      };
      "r retropie" = {
        hostname = "192.168.0.21";
        user = "pi";
      };
    };
  };
}
