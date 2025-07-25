{
    inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
    outputs = { nixpkgs, ... }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in {
        devShells.${system}.default = pkgs.mkShellNoCC {
            packages = with pkgs; [
                lua
            ];
        };
    };
}
