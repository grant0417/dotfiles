{
  description = "Home Manager configuration of grant";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  }: let
    username = "grant";
    homeDirectory = "/home/${username}";
    host = "grant-desktop";
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
    {
      homeConfigurations."${username}@${host}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs host username homeDirectory system;
        };
        modules = [
          ./home.nix
          {
            home = {inherit username homeDirectory;};
          }
        ];
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        formatter = pkgs.alejandra;
      }
    );
}
