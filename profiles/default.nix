{ utils }:

with utils.lib;

exportModules [
  ./ci
  ./common
  ./distributed-build
  ./file-sync
  ./interactive
  ./locale
  ./networking
  ./server
  ./ssh
  ./vpn
] // {
  hardware = exportModules [
    ./hardware/amdgpu.nix
    ./hardware/android.nix
  ];
}
