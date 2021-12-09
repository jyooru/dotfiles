{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    deploy-rs.url = "github:serokell/deploy-rs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, deploy-rs, flake-utils, ... }: {
    nixosConfigurations = (builtins.mapAttrs
      (host: system: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (./hosts/. + "/${host}")
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
  } // (flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs { inherit system; }; in
    {
      devShell = pkgs.mkShell {
        packages = (with pkgs;
          [ nixpkgs-fmt nix-linter ]);
      };
    }
  ));
}
