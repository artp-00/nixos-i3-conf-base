{
  description = "nixos-i3-basic-conf";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
        url = "github:nix-community/stylix";
        # Optional: pin nixpkgs version to match Stylix
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: let
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      YOUR_USERNAME = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        # > Our main nixos configuration file <
        modules = [
          ./configuration.nix
        ];
      };
    };

    # # Standalone home-manager configuration entrypoint
    # # Available through 'home-manager --flake .#your-username@your-hostname'
    # homeConfigurations = {
    #   "user@user-nixos" = home-manager.lib.homeManagerConfiguration {
    #     # Home-manager requires 'pkgs' instance
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux; # FIXME replace x86_64-linux with your architecure 
    #     extraSpecialArgs = {inherit inputs;};
    #     # > Our main home-manager configuration file <
    #     modules = [./home-manager/home.nix];
    #   };
    # };
  };
}
