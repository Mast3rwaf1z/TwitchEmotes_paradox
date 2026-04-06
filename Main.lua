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
    ["GlorpIthar"] = prefix .. "GlorpIthar.tga:28:28",
    ["skeidar"] = prefix .. "skeidar.tga:28:112",
    ["Shaw"] = prefix .. "Shaw.tga:28:28",
    ["Bark"] = prefix .. "Bark.tga:28:28",
    ["PillowTime"] = prefix .. "PillowTime.tga:28:28",
    ["HelloThere"] = prefix .. "HelloThere.tga:28:94",
    ["Xalatoes"] = prefix .. "Xalatoes.tga:28:36",
    ["Shroomer"] = prefix .. "Shroomer.tga:28:25",
    ["Rakoshere"] = prefix .. "Rakoshere.tga:28:28",
    ["LICKA"] = prefix .. "LICKA.tga:56:28",
    ["aaAAAAAaaaaaaaAAAAAaaaaaaaAAAAAa"] = prefix .. "aaAAAAAaaaaaaaAAAAAaaaaaaaAAAAAa.tga:56:28",
    ["PISSIN"] = prefix .. "PISSIN.tga:56:28",
    ["DvaAss"] = prefix .. "DvaAss.tga:56:28",
    ["MeAndTheBoysWatchingDvaAss"] = prefix .. "MeAndTheBoysWatchingDvaAss.tga:56:28",
    ["Looking"] = prefix .. "Looking.tga:28:28",
    ["DUNDUN"] = prefix .. "DUNDUN.tga:28:28",
    ["ALOO"] = prefix .. "ALOO.tga:28:28",
    ["DAWG"] = prefix .. "DAWG.tga:28:28",
    ["pogcat"] = prefix .. "pogcat.tga:28:28",
    ["HOPINDIBILEN"] = prefix .. "HOPINDIBILEN.tga:28:28",
    ["PREGONIC"] = prefix .. "PREGONIC.tga:28:28",
    ["DanSmile"] = prefix .. "DanSmile.tga:28:28"
}

TwitchEmotes_animation_metadata[prefix .. "GLYPHA.tga"] = {["nFrames"] = 94, ["frameWidth"] = 56, ["frameHeight"] = 56, ["imageWidth"]=56, ["imageHeight"]=5264, ["framerate"] = 50}
TwitchEmotes_animation_metadata[prefix .. "Rakoshere.tga"] = {["nFrames"] = 18, ["frameWidth"] = 32, ["frameHeight"] = 32, ["imageWidth"] = 32, ["imageHeight"] = 576, ["framerate"] = 10}
TwitchEmotes_animation_metadata[prefix .. "LICKA.tga"] = {["nFrames"] = 58, ["frameWidth"] = 32, ["frameHeight"] = 32, ["imageWidth"] = 32, ["imageHeight"] = 2048, ["framerate"] = 30}
TwitchEmotes_animation_metadata[prefix .. "aaAAAAAaaaaaaaAAAAAaaaaaaaAAAAAa.tga"] = {["nFrames"] = 3, ["frameWidth"] = 37, ["frameHeight"] = 32, ["imageWidth"] = 64, ["imageHeight"] = 128, ["framerate"] = 18}
TwitchEmotes_animation_metadata[prefix .. "PISSIN.tga"] = {["nFrames"] = 10, ["frameWidth"] = 32, ["frameHeight"] = 32, ["imageWidth"] = 32, ["imageHeight"] = 512, ["framerate"] = 7}
TwitchEmotes_animation_metadata[prefix .. "MeAndTheBoysWatchingDvaAss.tga"] = {["nFrames"] = 28, ["frameWidth"] = 64, ["frameHeight"] = 32, ["imageWidth"] = 64, ["imageHeight"] = 1024, ["framerate"] = 30}
TwitchEmotes_animation_metadata[prefix .. "DvaAss.tga"] = {["nFrames"] = 59, ["frameWidth"] = 57, ["frameHeight"] = 32, ["imageWidth"] = 64, ["imageHeight"] = 2048, ["framerate"] = 30}

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
    if AllTwitchEmoteNames ~= nil and Emoticons_Settings ~= nil and Emoticons_RenderSuggestionFN ~= nil and Emoticons_Settings["ENABLE_AUTOCOMPLETE"] then
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

-- THIS FOLLOWING CODE IS NOT MINE, I FOUND IT HERE: https://github.com/LOADGAlAXX/TwitchEmotes_Hardcore/blob/676eb836c661ed2d71f1c9d62bf9af054924ae48/main.lua#L126
--local function escpattern(x)
--    return (x:gsub('%%', '%%%%')
--             :gsub('^%^', '%%^')
--             :gsub('%$$', '%%$')
--             :gsub('%(', '%%(')
--             :gsub('%)', '%%)')
--             :gsub('%.', '%%.')
--             :gsub('%[', '%%[')
--             :gsub('%]', '%%]')
--             :gsub('%*', '%%*')
--             :gsub('%+', '%%+')
--             :gsub('%-', '%%-')
--             :gsub('%?', '%%?'))
--end
--
--function TwitchEmotesAnimator_UpdateEmoteInFontString(fontstring, widthOverride, heightOverride)
--    local txt = fontstring:GetText();
--    if (txt ~= nil) then
--        for emoteTextureString in txt:gmatch("(|TInterface\\AddOns\\TwitchEmotes.-|t)") do
--            local imagepath = emoteTextureString:match("|T(Interface\\AddOns\\TwitchEmotes.-tga).-|t")
--
--            local animdata = TwitchEmotes_animation_metadata[imagepath];
--            if (animdata ~= nil) then
--                local framenum = TwitchEmotes_GetCurrentFrameNum(animdata);
--                local nTxt;
--		-- it is not an emote suggestion and it is a wide animated emote
--		if (widthOverride ~= 16 and animdata.frameWidth > 32) then
--                    nTxt = txt:gsub(escpattern(emoteTextureString),
--                                        TwitchEmotes_BuildEmoteFrameStringWithDimensions(
--                                        imagepath, animdata, framenum, animdata.frameHeight, animdata.frameWidth))
--		elseif (widthOverride ~= nil or heightOverride ~= nil) then
--                    nTxt = txt:gsub(escpattern(emoteTextureString),
--                                        TwitchEmotes_BuildEmoteFrameStringWithDimensions(
--                                        imagepath, animdata, framenum, widthOverride, heightOverride))
--                else
--                    nTxt = txt:gsub(escpattern(emoteTextureString),
--                                      TwitchEmotes_BuildEmoteFrameString(
--                                        imagepath, animdata, framenum))
--                end
--
--                -- If we're updating a chat message we need to alter the messageInfo as wel
--                if (fontstring.messageInfo ~= nil) then
--                    fontstring.messageInfo.message = nTxt
--                end
--                fontstring:SetText(nTxt);
--                txt = nTxt;
--            end
--        end
--    end
--end


paradox_main()
