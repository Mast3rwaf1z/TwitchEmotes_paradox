{
    inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
    outputs = { nixpkgs, ... }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
        rewrite = pkgs.writeScriptBin "rewrite" ''
            from sys import argv
            input_file = argv[-1]
            output_file = ".".join(input_file.split(".")[:-1]) + ".tga"
            print(output_file)
        '';
    in {
        devShells.${system}.default = pkgs.mkShellNoCC {
            packages = with pkgs; [
                lua
                ffmpeg
                file
                feh
                (writeScriptBin "zip2tga" ''
                    #!${bash}/bin/bash
                    set -e
                    TEMPORARY_DIRECTORY=$(mktemp -d)
                    INPUT_ZIPFILE=$1
                    OUTPUT_DIRECTORY=$2
                    ${unzip}/bin/unzip $INPUT_ZIPFILE -d $TEMPORARY_DIRECTORY
                    cd $TEMPORARY_DIRECTORY
                    for file in *; do
                        output_file=$(${python3}/bin/python ${rewrite}/bin/rewrite $file)
                        ${ffmpeg}/bin/ffmpeg -i $file $OUTPUT_DIRECTORY/$output_file
                    done
                '')
            ];
        };
    };
}
