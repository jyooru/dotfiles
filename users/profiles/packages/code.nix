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
      yarn # javascript package manager
      nodePackages.typescript # typescript
      nodePackages.ts-node # typescript executor
      nodePackages.typescript-language-server # javascript/typescript language server
      jdk # java
      java-language-server
      kotlin
      kotlin-language-server
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
      (python3Full.withPackages (ps: with ps; [
        black # python formatter
        flake8 # python linter
        isort # python import formatter
        mypy # python type checker
        poetry # python package manager
        pytest # python test framework
        python-lsp-server # python language server
      ]))
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

    sessionVariables.JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
  };
}
