{
  description = "modular nixos config setup + flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
    };
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/laptop/configuration.nix
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hanyashi = import ./modules/home/default.nix;
            home-manager.backupFileExtension = "backup"; 
          }
      ];
    };
  };
}