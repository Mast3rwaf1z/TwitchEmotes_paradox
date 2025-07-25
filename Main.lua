local prefix = "Interface\\AddOns\\TwitchEmotes_paradox\\Emotes\\"

local paradox_emotes = {
    ["Vex"] = prefix .. "Vex.tga:64:64",
    ["CROW"] = prefix .."CROW.tga:64:64"
}


function paradox_table_length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function paradox_init_suggestions(paradox_suggestions)
    judhead_initsuggestions(paradox_suggestions)
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

    paradox_init_suggestions(suggestions)

    print("Successfully added " .. paradox_table_length(paradox_emotes) .. " new emotes through Skademanden's extra addon!")
end


paradox_main()

