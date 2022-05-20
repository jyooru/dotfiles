{ utils }:

with utils.lib;

exportModules [
  ./ci
  ./common
  ./distributed-build
  ./file-sync
  ./interactive
  ./ipfs
  ./locale
  ./networking
  ./server
  ./ssh
  ./vpn
  ./yggdrasil
] // {
  hardware = exportModules [
    ./hardware/amdgpu.nix
    ./hardware/android.nix
  ];
}
