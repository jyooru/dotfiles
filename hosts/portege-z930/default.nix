{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-z930";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/79fff45f-671c-45e4-8eb0-d9f3d855942a";
      preLVM = true;
      allowDiscards = true;
    };
  };

  services.nebula.networks."joel" = {
    listen.port = 4243;
    staticHostMap = {
      "10.42.0.11" = [ "home.run.joel.tokyo:4241" "192.168.0.11:4241" ];
      "10.42.0.12" = [ "home.run.joel.tokyo:4242" "192.168.0.12:4242" ];
      # "10.42.0.13" = [ "home.run.joel.tokyo:4243" "192.168.0.13:4243" ];
      "10.42.0.14" = [ "home.run.joel.tokyo:4244" "192.168.0.14:4244" ];
    };
    lighthouses = [
      "10.42.0.11"
      "10.42.0.12"
      # "10.42.0.13"
      "10.42.0.14"
    ];
  };

  services.syncthing = {
    folders = {
      # "archive" = {
      #   id = "u4tsv-7hxb7";
      #   path = "/home/joel/archive";
      #   # path = "/home/joel/files/archive";
      #   devices = [
      #     # "thinkpad-e580"
      #     "portege-r700-a"
      #     "ga-z77-d3h"
      #   ];
      # };
      "cluster" = {
        id = "jyxof-ssssq";
        path = "/home/joel/cluster";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          "portege-r700-b"
          # "portege-z930"
          "ga-z77-d3h"
        ];
      };
      "code" = {
        id = "wcqyy-zrab5";
        # path = "/home/joel/code";
        path = "/home/joel/files/code";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          "portege-r700-b"
          # "portege-z930"
          "ga-z77-d3h"
        ];
      };
      # "documents" = {
      #   id = "pgpew-tged2";
      #   path = "/home/joel/documents";
      #   # path = "/home/joel/files/documents";
      #   devices = [
      #     # "thinkpad-e580"
      #     "portege-r700-a"
      #     "ga-z77-d3h"
      #   ];
      # };
      # "games" = {
      #   id = "xt4t4-d2jad";
      #   path = "/home/joel/games";
      #   # path = "/home/joel/files/games";
      #   devices = [
      #     # "thinkpad-e580"
      #     "portege-r700-a"
      #     "ga-z77-d3h"
      #   ];
      # };
      # "media" = {
      #   id = "kasul-jsgfj";
      #   path = "/home/joel/media";
      #   # path = "/home/joel/files/media";
      #   devices = [
      #     # "thinkpad-e580"
      #     "portege-r700-a"
      #     "ga-z77-d3h"
      #   ];
      # };
      # "notes" = {
      #   id = "bc6qz-tad4c";
      #   path = "/home/joel/school";
      #   # path = "/home/joel/files/notes";
      #   devices = [
      #     # "thinkpad-e580"
      #     "portege-r700-a"
      #     "ga-z77-d3h"
      #   ];
      # };
      # "school" = {
      #   id = "s6jde-csrow";
      #   path = "/home/joel/school";
      #   # path = "/home/joel/files/school";
      #   devices = [
      #     # "thinkpad-e580"
      #     "portege-r700-a"
      #     "ga-z77-d3h"
      #   ];
      # };
      "tmp" = {
        id = "5f6yn-csxu7";
        path = "/home/joel/tmp";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          "portege-r700-b"
          # "portege-z930"
          "ga-z77-d3h"
        ];
      };
    };
  };
}
