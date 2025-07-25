local prefix = "Interface\\AddOns\\TwitchEmotes_paradox\\Emotes\\"

local paradox_emotes = {
    ["Vex"] = prefix .. "Vex.tga:64:64",
    ["SmallVex"] = prefix .. "Vex.tga:16:16",
    ["CROW"] = prefix .."CROW.tga:64:64"
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
