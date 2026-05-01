{ config, pkgs, lib, ... }:

let
  krisp-patcher =
    pkgs.writers.writePython3Bin "krisp-patcher"
      {
        libraries = with pkgs.python3Packages; [
          capstone
          pyelftools
        ];
        flakeIgnore = [
          "E501" 
          "F403" 
          "F405" 
        ];
      }
      (
        builtins.readFile (
          pkgs.fetchurl {
            url = "https://pastebin.com/raw/8tQDsMVd";
            sha256 = "sha256-IdXv0MfRG1/1pAAwHLS2+1NESFEz2uXrbSdvU9OvdJ8=";
          }
        )
      );
in
{
  boot.kernelParams = [ 
    "snd_intel_dspcfg.dsp_driver=1" 
    "snd_hda_intel.model=alc287-acer-nitro"
  ];
  boot.blacklistedKernelModules = [ "snd_hda_codec_hdmi" ];

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    krisp-patcher
    pavucontrol
    playerctl
    sof-firmware
    alsa-ucm-conf
  ];
}