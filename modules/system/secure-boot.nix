{ config, pkgs, lib, ... }:

{
  # boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.limine.enable = true;
  boot.loader.limine.secureBoot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.lanzaboote = {
  #   enable = true;
  #   pkiBundle = "/var/lib/sbctl";
  # };

  boot.loader.limine.style = {
    interface = {
      branding = "NixOS Bootloader";
      brandingColor = 6;
      helpColor = 6;
    };
    graphicalTerminal = {
      background = "0a0000";
      foreground = "c4c4c4";
      palette = "0a0000;480811;620a17;800e20;840e18;911022;bc1428;c4c4c4";
      paletteBright = "4f4e4e;480811;620a17;800e20;840e18;911022;bc1428;c4c4c4";
      margin = 0;
    };
  };

  boot.loader.limine.extraEntries = ''
    /Windows Boot Manager
    //Windows 11
    comment: Windows Boot Manager
    protocol: efi
    path: guid(9c0f6ce1-8e2e-4091-afab-83e1ac4446e8):/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}