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
    ["hugs"] = prefix .. "hugs.tga:28:28",
    ["RakoCaught"] = prefix .. "RakoCaught.tga:28:280",
    ["SifCaught"] = prefix .. "SifCaught.tga:28:280",
    ["misinformation"] = prefix .. "misinformation.tga:56:56",
    ["rakodead"] = prefix .. "rakodead.tga:28:28",
    ["LOGGERS"] = prefix .. "LOGGERS.tga:28:28",
    ["pepePI"] = prefix .. "pepePI.tga:28:28",
    ["VeryBerry"] = prefix .. "VeryBerry.tga:28:20",
    ["Ashdoora"] = prefix .. "Ashdoora.tga:28:28",
    ["GlorpIthar"] = prefix .. "GlorpIthar.tga:28:28"
}

TwitchEmotes_animation_metadata[prefix .. "GLYPHA.tga"] = {["nFrames"] = 94, ["frameWidth"] = 56, ["frameHeight"] = 56, ["imageWidth"]=56, ["imageHeight"]=5264, ["framerate"] = 50}

function paradox_table_length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function paradox_table_concat(t1, t2)
    t3 = {}
    for key, value in pairs(t1) do
        t3[key] = value
    end
    for key, value in pairs(t2) do
        t3[key] = value
    end
    return t3
end

function paradox_suggestion_reloader(suggestions)
    if (judhead_initsuggestions == nil) then
        local combined = paradox_table_concat(AllTwitchEmoteNames, suggestions)
        -- This loop is not mine, it is part of TwitchEmotes
        for _, frameName in pairs(CHAT_FRAMES) do
            local frame = _G[frameName]

            local editbox = frame.editBox;
            local suggestionList = combined;
            local maxButtonCount = 20;

            local autocompletesettings = {
                perWord = true,
                activationChar = ':',
                closingChar = ':',
                minChars = 2,
                fuzzyMatch = true,
                onSuggestionApplied = function(suggestion)
                    UpdateEmoteStats(suggestion, true, false, false);
                end,
                renderSuggestionFN = Emoticons_RenderSuggestionFN,
                suggestionBiasFN = function(suggestion, text)
                    --Bias the sorting function towards the most autocompleted emotes
                    if TwitchEmoteStatistics[suggestion] ~= nil then
                        return TwitchEmoteStatistics[suggestion][1] * 5
                    end
                    return 0;
                end,
                interceptOnEnterPressed = true,
                addSpace = true,
                useTabToConfirm = Emoticons_Settings["AUTOCOMPLETE_CONFIRM_WITH_TAB"],
                useArrowButtons = true,
            }

            SetupAutoComplete(editbox, suggestionList, maxButtonCount, autocompletesettings);
        end
    else
        local i = paradox_table_length(suggestions)
        for name, path in pairs(judhead_emotes) do
            suggestions[i] = name
            i = i + 1
        end
        judhead_initsuggestions(suggestions)
    end
end

local function paradox_main() 
    print("Hello from Custom Paradox Twitch Emotes by Skademanden!")

    local dropdown = { "Paradox" }
    local i = 1
    local suggestions = {}
    for name, path in pairs(paradox_emotes) do
        table.insert(dropdown, name)
        TwitchEmotes:AddEmote(name, name, path)
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
