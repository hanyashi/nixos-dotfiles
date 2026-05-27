{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.millennium.overlays.default ];

  services.flatpak.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
    package = pkgs.millennium-steam;
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}