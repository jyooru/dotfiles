{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, home-manager, deploy-rs, ... }: {
    nixosConfigurations = (builtins.mapAttrs
      (name: value: nixpkgs.lib.nixosSystem {
        system = value;
        modules = [
          (./hosts/. + "/${name}")
          home-manager.nixosModules.home-manager
          ./default.nix
        ];
      })
      {
        "thinkpad-e580" = "x86_64-linux";
        "portege-r700-a" = "x86_64-linux";
        "portege-r700-b" = "x86_64-linux";
        "portege-z930" = "x86_64-linux";
        "ga-z77-d3h" = "x86_64-linux";
      }
    );

    deploy = {
      sshUser = "root";
      user = "root";

      nodes = {
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
  };
}
