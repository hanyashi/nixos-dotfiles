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

  boot.loader.limine.extraConfig = ''
    interface_branding: NixOS Bootloader
    interface_branding_color: 1
    term_background: 0a0000
    term_foreground: c4c4c4
    term_palette: 0a0000;480811;620a17;800e20;840e18;911022;bc1428;c4c4c4
    term_palette_bright: 4f4e4e;480811;620a17;800e20;840e18;911022;bc1428;c4c4c4

    /Windows Boot Manager
    comment: Windows 11
    protocol: efi_chainload
    image_path: guid(24e9f9e4-d0b7-4c03-a678-4d2c3f144ea6):/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}