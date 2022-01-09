{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/AMD_GPU

  # driver
  boot.initrd.kernelModules = [ "amdgpu" ];

  # opencl
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
  ];

  # vulkan
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
