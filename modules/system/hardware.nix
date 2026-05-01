{ config, pkgs, lib, ... }:

let
  rakk-dasig-driver = config.boot.kernelPackages.callPackage ({ stdenv, fetchFromGitHub, kernel }:
    stdenv.mkDerivation {
      pname = "hid-rakk-dasig-x";
      version = "master";

      src = fetchFromGitHub {
        owner = "keenplify";
        repo = "hid-rakk-dasig-x";
        rev = "master"; 
        sha256 = "sha256-Ig0J1a2vfbdya8qNw8VY0oZPiqCYqDSUCX286TPYcr0=";
      };

      patchPhase = ''
        sed -i 's|/lib/modules/$(shell uname -r)/build|${kernel.dev}/lib/modules/${kernel.modDirVersion}/build|g' Makefile
        sed -i 's|/lib/modules/$(KERNELRELEASE)/build|${kernel.dev}/lib/modules/${kernel.modDirVersion}/build|g' Makefile
      '';

      nativeBuildInputs = kernel.moduleBuildDependencies;

      makeFlags = [
        "KERNELRELEASE=${kernel.modDirVersion}"
      ];

      installPhase = ''
        install -D hid-rakk-dasig-x.ko -t $out/lib/modules/${kernel.modDirVersion}/extra
      '';
    }) {};
in
{
  imports = [ 
    ./nbfc.nix 
  ];

  boot.extraModulePackages = [ rakk-dasig-driver ];
  boot.kernelModules = [ "hid-rakk-dasig-x" ];
  boot.kernelParams = [ "usbhid.quirks=0x248a:0xfb01:0x00000040" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true; 
    };
  };

  programs.light.enable = true;

}