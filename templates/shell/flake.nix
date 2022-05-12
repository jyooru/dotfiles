{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = { self, nixpkgs, utils } @ inputs:
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels:
        with channels.nixpkgs;
        {
          devShells = rec {
            default = shell;
            shell = mkShell {
              packages = [ hello ];
            };
          };
        };
    };
}
