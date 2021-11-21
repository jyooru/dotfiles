{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    home-manager.url = "github:nix-community/home-manager";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, home-manager, deploy-rs, ... }: {
    nixosConfigurations = {
      thinkpad-e580 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/thinkpad-e580 home-manager.nixosModules.home-manager ./default.nix ];
      };
      portege-r700-a = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/portege-r700-a home-manager.nixosModules.home-manager ./default.nix ];
      };
      portege-r700-b = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/portege-r700-b home-manager.nixosModules.home-manager ./default.nix ];
      };
      portege-z930 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/portege-z930 home-manager.nixosModules.home-manager ./default.nix ];
      };
      ga-z77-d3h = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/ga-z77-d3h home-manager.nixosModules.home-manager ./default.nix ];
      };
    };
    deploy.nodes = {
      portege-r700-a = {
        hostname = "portege-r700-a.dev.joel.tokyo";
        profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.portege-r700-a;
      };
      portege-r700-b = {
        hostname = "portege-r700-b.dev.joel.tokyo";
        profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.portege-r700-b;
      };
      portege-z930 = {
        hostname = "portege-z930.dev.joel.tokyo";
        profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.portege-z930;
      };
      ga-z77-d3h = {
        hostname = "ga-z77-d3h.dev.joel.tokyo";
        profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.ga-z77-d3h;
      };
    };
  };
}
