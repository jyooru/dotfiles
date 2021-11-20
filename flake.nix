{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { home-manager, nixpkgs, ... }: {
    nixosConfigurations = {
      thinkpad-e580 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/thinkpad-e580 home-manager.nixosModules.home-manager ./default.nix ];
      };
      ga-z770-d3h = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/ga-z77-d3h home-manager.nixosModules.home-manager ./default.nix ];
      };
    };
  };
}
