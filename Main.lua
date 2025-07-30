local prefix = "Interface\\AddOns\\TwitchEmotes_paradox\\Emotes\\"

local paradox_emotes = {
    ["BigVex"] = prefix .. "Vex.tga:56:56",
    ["Vex"] = prefix .. "Vex.tga:28:28",
    ["WideVex"] = prefix .. "Vex.tga:28:56",
    ["Crow"] = prefix .."CROW.tga:28:28",
    ["PogCrash"] = prefix .. "PogCrash.tga:28:28",
    ["BigPogCrash"] = prefix .. "PogCrash.tga:56:56",
    ["Amogus"] = prefix .. "Amogus.tga:28:28",
    ["SIRE"] = prefix .. "SIRE.tga:40:60",
    ["Xoy"] = prefix .. "frick.tga:28:28",
    ["YOUKNOWWHOELSE"] = prefix .. "muscleman.tga:28:28",
    ["goku"] = prefix .. "goku.tga:28:28",
    ["AAAA"] = prefix .. "AAAA.tga:28:28",
    ["GLYPHA"] = prefix .. "GLYPHA.tga:56:56",
    ["hugs"] = prefix .. "hugs.tga:28:28"
}

TwitchEmotes_animation_metadata[prefix .. "GLYPHA.tga"] = {["nFrames"] = 94, ["frameWidth"] = 56, ["frameHeight"] = 56, ["imageWidth"]=56, ["imageHeight"]=5264, ["framerate"] = 50}

function paradox_table_length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function paradox_suggestion_reloader(suggestions)
    -- I'll finish some other time
    judhead_initsuggestions(suggestions)
end

local function paradox_main() 
    print("Hello from Custom Paradox Twitch Emotes by Skademanden")

    local dropdown = { "Paradox" }
    local i = 1
    local suggestions = {}
    for name, path in pairs(paradox_emotes) do
        table.insert(dropdown, name)
        TwitchEmotes:AddEmote(name, name, path)
        suggestions[i] = name
        i = i + 1
    end

    for name, path in pairs(judhead_emotes) do
        suggestions[i] = name
        i = i + 1
    end

    table.insert(TwitchEmotes_dropdown_options, dropdown)

    -- This is so stupid, but it works
    -- Should probably be replaced with a generic reloader so other people don't have to go through this...
    paradox_suggestion_reloader(suggestions)

    print("Successfully added " .. paradox_table_length(paradox_emotes) .. " new emotes through Skademanden's extra addon!")
end


paradox_main()
