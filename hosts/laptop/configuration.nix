{ config, pkgs, lib, inputs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/hardware.nix
    ../../modules/system/audio.nix
    ../../modules/system/desktop.nix
    ../../modules/system/gaming.nix
    ../../modules/system/secure-boot.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # boot
  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/0b238293-bd36-4495-8d67-1bdd7dac46de";
    preLVM = true;
  };
  
  #
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Manila";
  i18n.defaultLocale = "en_PH.UTF-8";
  
  # 
  users.users.hanyashi = {
    isNormalUser = true;
    description = "hanyashi";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
  };

  # 
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # virtualization
  virtualisation.docker.enable = true;

  # cli
  environment.systemPackages = with pkgs; [
    vim wget git gh fastfetch kitty
    pciutils brightnessctl docker coreutils qdirstat
    btop lon xev evtest libinput nodejs
  ];

  # maintenance
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "25.11"; 
}