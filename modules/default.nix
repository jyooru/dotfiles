{
  imports = [
    ./bootloader.nix
    ./config/distributed-build.nix
    ./hardware/amdgpu.nix
    ./hardware/android.nix
    ./packages.nix
  ];
}
