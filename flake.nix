{
  description = "NixOS configuration";

  inputs = {
    deploy-rs.url = "github:serokell/deploy-rs";
    digga = { url = "github:divnix/digga"; inputs = { deploy.follows = "deploy-rs"; nixpkgs.follows = "nixpkgs"; nixlib.follows = "nixpkgs"; home-manager.follows = "home-manager"; }; };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small"; # change back to nixos-unstable on next update
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, digga, nixpkgs, home-manager, deploy-rs, flake-utils, nur, ... }:
    let
      overlays = import ./overlays;
      overlay = overlays.pkgs;
    in
    {
      nixosConfigurations = (builtins.mapAttrs
        (host: system: nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (./hosts/. + "/${host}")
            ./default.nix
            home-manager.nixosModules.home-manager
            { nixpkgs.overlays = [ nur.overlay ]; }
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

        nodes = (builtins.listToAttrs (builtins.map
          (name: {
            inherit name;
            value = {
              hostname = "${name}.dev.joel.tokyo";
              profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${name};
            };
          })
          [ "portege-r700-a" "portege-r700-b" "portege-z930" "ga-z77-d3h" ]
        ));
      };

      inherit overlay overlays;

    } // (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; }; in
      with pkgs;
      rec {
        devShell = mkShell {
          packages = [ nixpkgs-fmt deploy-rs.outputs.packages.${system}.deploy-rs ];
        };

        legacyPackages = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
        packages = import ./pkgs { inherit pkgs; };
      }
    ));
}
