#!/usr/bin/env bash
set -e

OUTPUT_PATH="$(basename "$PWD").toc"

# INPUT VALIDATION
if [ -z "$1" ]; then
    echo "Error, please provide an interface version as first argument"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Error, please provide an addon version as second argument"
    exit 1
fi

if [ -f "$OUTPUT_PATH" ]; then
    echo "Error, file '$OUTPUT_PATH' already exists"
    exit 1
fi
# END INPUT VALIDATION

# METADATA 
metadata="{
    \"Interface\": \"$1\",
    \"Title\": \"|TInterface\\\\Addons\\\\TwitchEmotes_paradox\\\\Emotes\\\\Vex:0|tTwitch Emotes: PARADOX|TInterface\\\\Addons\\\\TwitchEmotes_paradox\\\\Emotes\\\\Vex:0|t\",
    \"IconTexture\": \"Interface\\\\AddOns\\\\TwitchEmotes\\\\Emotes\\\\1337.tga\",
    \"Author\": \"Skademanden - Argent Dawn (EU)\",
    \"Notes\": \"Modifies the popular twitch emotes addon\",
    \"Version\": \"$2\",
    \"Dependencies\": \"TwitchEmotes\",
    \"OptionalDeps\": \"TwitchEmotes_Giga\"
}"

files="[
    \"Main.lua\"
]"
# END METADATA

# DATA PROCESSING
echo "$metadata" | jq -r 'to_entries[] | "## \(.key): \(.value)"' >> "$OUTPUT_PATH"

# add a newline to mimic static files
echo "" >> "$OUTPUT_PATH"

echo "$files" | jq -r '.[]' | while read -r file; do
    echo "$file" >> "$OUTPUT_PATH"
done
