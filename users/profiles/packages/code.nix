{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodePackages.prettier # * formatter
    caddy # caddyfile formatter and web server
    go # go
    rustup # rust
    python3 # python
    python3Packages.black # python formatter
    python3Packages.flake8 # python linter
    python3Packages.isort # python import formatter
    python3Packages.mypy # python type checker
    python3Packages.poetry # python package manager
    python3Packages.pytest # python test framework
    nixpkgs-fmt # nix formatter
    statix # nix linter
    deadnix # nix unused code scanner
    nixpkgs-review # nixpkgs pull request reviewing tool
  ];
}
