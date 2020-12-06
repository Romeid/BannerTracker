function BANT:Set(list)
    local set = {}
    for _, l in ipairs(list) do
        set[l] = true
    end
    return set
end

function BANT:TableHasKey(table, key)
    return table[key] ~= nil
end

function BANT:DumpTable(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function BANT:PrintText(text, colorType)
    if (colorType == "warning") then
        print(BANT.Color_Brand .. "[BANT]: " .. BANT.Color_Warning .. text)
    elseif (colorType == "critical") then
        print(BANT.Color_Brand .. "[BANT]: " .. BANT.Color_Critical .. text)
    else
        print(BANT.Color_Brand .. "[BANT]: " .. BANT.Color_Default .. text)
    end

end

function BANT:PlaySound(fileName)
    if (BANT.db.profile.sound_channel ~= "a_none") then
        local isNumber = tonumber(fileName);
        if (isNumber) then
            if (BANT.db.profile.sound_channel == "b_master") then
                PlaySound(isNumber, "Master")
            elseif (BANT.db.profile.sound_channel == "c_sound") then
                PlaySound(isNumber)
            end
        else
            if (BANT.db.profile.sound_channel == "b_master") then
                PlaySoundFile(fileName, "Master")
            elseif (BANT.db.profile.sound_channel == "c_sound") then
                PlaySoundFile(fileName)
            end
        end
    end
end

function BANT:CommaSeparatedNum(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

-- Used to escape "'s by toCSV
function BANT:escapeCSV(s)
    if string.find(s, '[,"]') then
        s = '"' .. string.gsub(s, '"', '""') .. '"'
    end
    return s
end

-- Convert from CSV string to table (converts a single line of a CSV file)
function BANT:fromCSV(s)
    s = s .. ',' -- ending comma
    local t = {} -- table to collect fields
    local fieldstart = 1
    repeat
        -- next field is quoted? (start with `"'?)
        if string.find(s, '^"', fieldstart) then
            local a, c
            local i = fieldstart
            repeat
                -- find closing quote
                a, i, c = string.find(s, '"("?)', i + 1)
            until c ~= '"' -- quote not followed by quote?
            if not i then
                error('unmatched "')
            end
            local f = string.sub(s, fieldstart + 1, i - 1)
            table.insert(t, (string.gsub(f, '""', '"')))
            fieldstart = string.find(s, ',', i) + 1
        else -- unquoted; find next comma
            local nexti = string.find(s, ',', fieldstart)
            table.insert(t, string.sub(s, fieldstart, nexti - 1))
            fieldstart = nexti + 1
        end
    until fieldstart > string.len(s)
    return t
end

function BANT:toCSV(tt)
    local s = ""
    -- ChM 23.02.2014: changed pairs to ipairs 
    -- assumption is that fromCSV and toCSV maintain data as ordered array
    for _, p in ipairs(tt) do
        s = s .. "," .. BANT:escapeCSV(p)
    end
    return string.sub(s, 2) -- remove first comma
end

function BANT:tobool(v)
    return v and ( (type(v)=="number") and (v==1) or ( (type(v)=="string") and (v=="true" or v=="1") ) )
end

function BANT:PlayerSentMessage(sender)
    -- Since \b and alike doesnt exist: use "frontier pattern": %f[%A]
    return string.match(sender, GetUnitName("player") .. "%f[%A]") ~= nil;
end

function BANT:SecondsToDisplayTime(seconds)
    seconds = tonumber(seconds);
    local minutes = string.format("%1.f", math.floor(seconds / 60));
    local seconds = string.format("%02.f", math.floor(seconds - (minutes * 60)));
    return minutes .. ":" .. seconds
end

BANT.ID_XPBanner_Epic_Horde = 64402;
BANT.ID_XPBanner_Blue_Horde = 64401;
BANT.ID_XPBanner_Green_Horde = 64400;

BANT.ID_XPBanner_Epic_Alliance = 64399;
BANT.ID_XPBanner_Blue_Alliance = 64398;
BANT.ID_XPBanner_Green_Alliance = 63359;


BANT.TTM_ID_Horde = 61447 -- TTM = Traveler's Tundra Mammoth Horde
BANT.TTM_ID_Alliance = 61425 -- TTM = Traveler's Tundra Mammoth Alliance 
BANT.GEY_ID = 122708 -- GEY = Grand Expedition Yak
BANT.Jeeves_ID = 49040 -- Jeeves
BANT.MCB_ID = 264058 -- Mighty Caravan Brutosaur
BANT.ME_ID = 40768 -- Moll-e
BANT.SW_ID = 261602 -- Stampwhistle
BANT.VendorList = BANT:Set{BANT.TTM_ID_Horde, BANT.TTM_ID_Alliance, BANT.GEY_ID, BANT.Jeeves_ID, BANT.MCB_ID};
BANT.AuctionHouseList = BANT:Set{BANT.MCB_ID};
BANT.MailboxList = BANT:Set{BANT.ME_ID, BANT.SW_ID};

BANT.Announcement_OxStatueWarningTime = 75

BANT.SessionPromptString = "[Hyperspawn Tracker]-SessionStart";
BANT.BroadcastCooldown = 60;

---- Color Variables----
BANT.Color_Brand = "|c00FFA500";
BANT.Color_Warning = "|c00ffff00";
BANT.Color_Critical = "|c00ff0000";
BANT.Color_Default = "|c00ffffff";
BANT.Color_EpicQuality = "|c00a335ee";
BANT.Color_White = "|c00ffffff";

---- UI Constants ----
BANT.FontSize = 14;
BANT.LeftPadding = 10;
BANT.LineHeight = 20;
BANT.TopPadding = 10;
