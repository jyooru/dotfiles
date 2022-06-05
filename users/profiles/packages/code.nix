{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      nodePackages.prettier # * formatter
      nodePackages.bash-language-server # bash language server
      caddy # caddyfile formatter and web server
      go # go
      gopls # go language server
      nodejs # javascript
      nodePackages.nodemon # javascript auto reload helper
      nodePackages.typescript # typescript
      nodePackages.ts-node # typescript executor
      nodePackages.typescript-language-server # javascript/typescript language server
      (with fenix; combine [
        # rust
        stable.rustc
        stable.cargo
        stable.clippy
        stable.rust-src
        stable.rustfmt
        rust-analyzer
      ])
      gcc # rust compile dependency
      cargo-edit # rust package manager addon - lets me "cargo add x"
      python3 # python
      python3Packages.black # python formatter
      python3Packages.flake8 # python linter
      python3Packages.isort # python import formatter
      python3Packages.mypy # python type checker
      python3Packages.poetry # python package manager
      python3Packages.pytest # python test framework
      python3Packages.python-lsp-server # python language server
      deploy-rs.deploy-rs # nixos deployment tool
      nixpkgs-fmt # nix formatter
      statix # nix linter
      rnix-lsp # nix language server
      nodePackages.node2nix # nix node tool
      fup-repl # nix repl tool
      deadnix # nix unused code scanner
      ragenix # nixos secret encryption tool
      nixpkgs-review # nixpkgs pull request reviewing tool
    ];
  };
}
