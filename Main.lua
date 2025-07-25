local prefix = "Interface\\AddOns\\TwitchEmotes_paradox\\Emotes\\"

local paradox_emotes = {
    ["BigVex"] = prefix .. "Vex.tga:64:64",
    ["Vex"] = prefix .. "Vex.tga:16:16",
    ["WideVex"] = prefix .. "Vex.tga:32:128",
    ["Crow"] = prefix .."CROW.tga:64:64",
    ["PogCrash"] = prefix .. "PogCrash.tga:16:16",
    ["BigPogCrash"] = prefix .. "PogCrash.tga:64:64",
    ["Amogus"] = prefix .. "Amogus.tga:20:20",
    ["SIRE"] = prefix .. "SIRE.tga:40:60",
    ["frick"] = prefix .. "frick.tga:28:28"
}


function paradox_table_length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
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
    judhead_initsuggestions(suggestions)

    print("Successfully added " .. paradox_table_length(paradox_emotes) .. " new emotes through Skademanden's extra addon!")
end


paradox_main()
