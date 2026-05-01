{ config, pkgs, ... }:

{
  services.flatpak.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}