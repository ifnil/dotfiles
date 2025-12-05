{
  description = "An empty flake template that you can adapt to your own environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    myim = {
      url = "github:ifnil/myim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , myim
    , ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forEachSystem = f: nixpkgs.lib.genAttrs systems f;
      pkgsFor = forEachSystem (system: nixpkgs.legacyPackages.${system});
    in
    {
      nixosConfigurations."melon" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/melon/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.june = import ./home/hosts/linux.nix;
            home-manager.extraSpecialArgs = {
              inherit myim;
            };
            home-manager.sharedModules = [
              myim.homeModules.default
            ];
          }
        ];
      };

      homeConfigurations = {
        "june" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;

          modules = [
            ./home/hosts/linux.nix
            myim.homeModules.default
          ];
        };

        "work" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.aarch64-darwin;

          modules = [
            ./home/hosts/work.nix
            myim.homeModules.default
          ];
        };
      };
    };
}
