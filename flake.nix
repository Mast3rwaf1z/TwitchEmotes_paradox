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
                bat
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
        packages.${system}.default = pkgs.writeScriptBin "getVersions" ''
            #!${pkgs.bash}/bin/bash
            set -e
            # load api key
            echo "Loading API Key..."
            source ./.env
            if [ -z "$CURSEFORGE_API_KEY" ]; then
                echo "Error! No API key found, please set CURSEFORGE_API_KEY to your API key in a .env file."
                exit 1
            fi

            if [ -z "$1" ]; then
                echo "Error, please give the desired version of the game as the first argument"
                exit 1
            fi

            response=$(${pkgs.curl}/bin/curl https://wow.curseforge.com/api/game/versions -H "x-api-token: $CURSEFORGE_API_KEY" 2>/dev/null)

            interface=$(echo "$response" | ${pkgs.jq}/bin/jq -r ".[] | select(.name == \"$1\") | .apiVersion")
            game_version=$(echo "$response" | ${pkgs.jq}/bin/jq -r ".[] | select(.name == \"$1\") | .id")

            echo "interface: $interface"
            echo "game_version: $game_version"
        '';
    };
}
