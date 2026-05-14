{ config, pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = false;
  services.desktopManager.plasma6.enable = true;
  services.xserver.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*"; 
  }; 

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL glib xorg.libX11 xorg.libXext libxkbcommon fontconfig freetype
    xorg.libxcb xorg.xcbutil xorg.xcbutilwm xorg.xcbutilimage
    xorg.xcbutilkeysyms xorg.xcbutilrenderutil xorg.libSM xorg.libICE
  ];

  environment.systemPackages = with pkgs; [
    firefox discord rofi discord-ptb obs-studio vscode
    vlc spotify teams-for-linux imagemagick lmms unrar
    (python3.withPackages (ps: with ps; [ pywal haishoku ])) 
  ];
}