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
      # Support multiple systems
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forEachSystem = f: nixpkgs.lib.genAttrs systems f;
      pkgsFor = forEachSystem (system: nixpkgs.legacyPackages.${system});
    in
    {
      homeConfigurations."melon" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;

        modules = [
          ./hosts/melon
          myim.homeModules.default
        ];
      };

      homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.aarch64-darwin;

        modules = [
          ./home/hosts/work.nix
          myim.homeModules.default
        ];
      };
    };
}
