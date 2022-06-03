{
  description = "NixOS configuration";

  inputs = {
    comma.url = "github:nix-community/comma";
    deploy.url = "github:serokell/deploy-rs";
    fenix.url = "github:nix-community/fenix";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    minecraft-servers.url = "github:jyooru/nix-minecraft-servers";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nur.url = "github:nix-community/nur";
    ragenix.url = "github:yaxitech/ragenix";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = { self, comma, deploy, fenix, home-manager, minecraft-servers, nixpkgs, nur, ragenix, utils, ... } @ inputs:

    with deploy.lib.x86_64-linux;
    with nixpkgs.lib;
    with utils.lib;

    mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channelsConfig = import ./profiles/common/nixpkgs.nix;
      sharedOverlays = [
        (final: _: { inherit (comma.packages.${final.system}) comma; })
        deploy.overlay
        fenix.overlay
        nur.overlay
        ragenix.overlay
        minecraft-servers.overlays.default
      ] ++ (attrValues self.overlays);
      channels.nixpkgs.patches = [
        ./patches/fix-yggdrasil.patch
        ./patches/mosh-no-firewall-open.patch
        ./patches/qtile-without-wlroots.patch
      ];

      hostDefaults = {
        specialArgs = rec {
          inherit self inputs;
          profiles = import ./profiles { inherit utils; };
          users = import ./users { inherit utils; };
          secrets = import ./secrets;
          suites = with profiles; {
            base = [ common file-sync locale networking users.joel users.root ssh vpn ];
            server = suites.base ++ [ server ];
          };
        };
        modules = (attrValues (import ./services { inherit utils; })) ++ [
          home-manager.nixosModule
          ragenix.nixosModules.age
        ];
      };
      hosts = import ./hosts { inherit utils; };
      deploy = {
        nodes = mapAttrs
          (_: configuration: {
            hostname = configuration.config.networking.fqdn;
            profiles.system.path = activate.nixos configuration;
          })
          self.nixosConfigurations;

        sshUser = "root";
      };

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs; in
        with pkgs; {
          devShells.default = mkShell {
            packages = [
              nixpkgs-fmt
              nodePackages.node2nix
              qtile
            ]
            ++ (import ./users/profiles/packages/code.nix { inherit pkgs; }).home.packages;
          };

          packages = import ./packages { inherit pkgs system; };
        };

      templates = import ./templates;

      overlays = import ./overlays;
    };
}
