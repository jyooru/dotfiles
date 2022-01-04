{
  imports = [
    ./bootloader.nix
    ./config/distributed-build.nix
    ./file-sync.nix
    ./hardware/amdgpu.nix
    ./hardware/android.nix
    ./packages.nix
  ];
}
