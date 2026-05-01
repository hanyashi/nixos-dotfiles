{ pkgs, ... }: 
let
  filename = "nbfc/nbfc.json";

  # IMPORTANT: Change "Acer Nitro AN515-43" to your specific laptop model's config ID
  laptopConfig = ''
    {"SelectedConfigId": "Acer Nitro AN515-58"}
  '';
in {
  environment.systemPackages = with pkgs; [
    nbfc-linux
  ];

  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig.Type = "simple";
    path = [ pkgs.kmod ];
    script = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file '/etc/${filename}'";
    wantedBy = ["multi-user.target"];
  };

  environment.etc."${filename}".text = laptopConfig;
}
  