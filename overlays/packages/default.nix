final: prev:
import ../../packages {
  pkgs = final;
  inherit (final) system;
}
