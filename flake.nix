{
  description =
    "An empty flake template that you can adapt to your own environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    myim = {
      url = "path:/home/june/git/myim";
      # url = "github:ifnil/myim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, myim, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."june" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home
          myim.homeModules.default
        ];
      };
    };
}
