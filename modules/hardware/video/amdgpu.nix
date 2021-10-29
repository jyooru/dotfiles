{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.hardware.video.amdgpu;
in

{
  options.modules.hardware.video.amdgpu = {
    enable = mkEnableOption "AMD GPU Support";
  };
  config = mkIf cfg.enable {
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
  };
}
