{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = { self, nixpkgs, utils } @ inputs:
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs; in
        with pkgs;
        rec {
          devShells = rec {
            change-me = (poetry2nix.mkPoetryEnv { projectDir = ./.; }).env;
            default = change-me;
          };

          packages = (self.overlays.default pkgs pkgs) // {
            default = packages.change-me;
          };
        };

      overlays = rec {
        change-me = final: _prev: {
          change-me = final.poetry2nix.mkPoetryApplication { projectDir = ./.; };
        };
        default = change-me;
      };
    };
}
