function BANT.GetPlayerInfoObj()
    return {
        userName = BANT.db.char.userName,
        epicBanner = {
            hasItem = BANT.db.char.epicBanner.hasItem,
            startTime = BANT.db.char.epicBanner.startTime,
            cdLength = BANT.db.char.epicBanner.cdLength
        },
        blueBanner = {
            hasItem = BANT.db.char.blueBanner.hasItem,
            startTime = BANT.db.char.blueBanner.startTime,
            cdLength = BANT.db.char.blueBanner.cdLength
        },
        greenBanner = {
            hasItem = BANT.db.char.greenBanner.hasItem,
            startTime = BANT.db.char.greenBanner.startTime,
            cdLength = BANT.db.char.greenBanner.cdLength
        }
    };
end

function BANT.GetBannerCooldownDisplayText(bannerInfo)
    if (bannerInfo.startTime == nil) then
        return "?";
    end
    
    if (BANT:tobool(bannerInfo.hasItem) and bannerInfo.startTime) then
        local cooldown = math.floor((bannerInfo.startTime + bannerInfo.cdLength) - GetTime());
        if (cooldown > 0) then
            return BANT:SecondsToDisplayTime(cooldown);
        else
            return "0";
        end
        
    else
        return "X";
    end
end

function BANT.GetPlayersFaction()
    local faction, _ = UnitFactionGroup("player")
    return faction;
end

function BANT.GetEpicBannerID()
    if (BANT.GetPlayersFaction() == "Horde") then
        return BANT.ID_XPBanner_Epic_Horde;
    else
        return BANT.ID_XPBanner_Epic_Alliance;
    end
end

function BANT.GetBlueBannerID()
    if (BANT.GetPlayersFaction() == "Horde") then
        return BANT.ID_XPBanner_Blue_Horde;
    else
        return BANT.ID_XPBanner_Blue_Alliance;
    end
end

function BANT.GetGreenBannerID()
    if (BANT.GetPlayersFaction() == "Horde") then
        return BANT.ID_XPBanner_Green_Horde;
    else
        return BANT.ID_XPBanner_Green_Alliance;
    end
end



function BANT.UpdateCooldownInfo()
    ----------------------------------------------------------------------------------------------
    ------------------------------------ EPIC BANNER ---------------------------------------------
    ----------------------------------------------------------------------------------------------
    local epicBannerCount = GetItemCount(BANT.GetEpicBannerID());
    local epicBannerStartTime, epicBannerCooldownLength, _ = GetItemCooldown(BANT.GetEpicBannerID());

    -- has item available
    if (epicBannerCount > 0) then
        
        BANT.db.char.epicBanner.hasItem = 1;
        
        BANT.db.char.epicBanner = {
            hasItem = 1,
            startTime = epicBannerStartTime,
            cdLength = epicBannerCooldownLength
        };
    else
        BANT.db.char.epicBanner = {
            hasItem = 0,
            startTime = 0,
            cdLength = 0
        };
    end

    ----------------------------------------------------------------------------------------------
    ------------------------------------ BLUE BANNER ---------------------------------------------
    ----------------------------------------------------------------------------------------------
    local blueBannerCount = GetItemCount(BANT.GetBlueBannerID());
    local blueBannerStartTime, blueBannerCooldownLength, _ = GetItemCooldown(BANT.GetBlueBannerID());

    if (blueBannerCount > 0) then
        BANT.db.char.blueBanner.hasItem = 1;
        
        BANT.db.char.blueBanner = {
            hasItem = 1,
            startTime = blueBannerStartTime,
            cdLength = blueBannerCooldownLength
        };
    else
        BANT.db.char.blueBanner = {
            hasItem = 0,
            startTime = 0,
            cdLength = 0
        };
    end

    ----------------------------------------------------------------------------------------------
    ------------------------------------ GREEN BANNER --------------------------------------------
    ----------------------------------------------------------------------------------------------
    local greenBannerCount = GetItemCount(BANT.GetGreenBannerID());
    local greenBannerStartTime, greenBannerCooldownLength, _ = GetItemCooldown(BANT.GetGreenBannerID());

    if (greenBannerCount > 0) then
        BANT.db.char.greenBanner.hasItem = 1;
        
        BANT.db.char.greenBanner = {
            hasItem = 1,
            startTime = greenBannerStartTime,
            cdLength = greenBannerCooldownLength
        };
    else
        BANT.db.char.greenBanner = {
            hasItem = 0,
            startTime = 0,
            cdLength = 0
        };
    end
end

function BANT.BroadcastCooldownInfo()
    local inParty = IsInGroup(LE_PARTY_CATEGORY_HOME);

    if (inParty) then
        local array = 
            {   
                BANT.db.char.userName, 
                BANT.db.char.epicBanner.hasItem, BANT.db.char.epicBanner.startTime, BANT.db.char.epicBanner.cdLength,
                BANT.db.char.blueBanner.hasItem, BANT.db.char.blueBanner.startTime, BANT.db.char.blueBanner.cdLength,
                BANT.db.char.greenBanner.hasItem, BANT.db.char.greenBanner.startTime, BANT.db.char.greenBanner.cdLength
            };
        local msgToSend = BANT:toCSV(array);
        local success = C_ChatInfo.SendAddonMessage("BANNERTRACKER", msgToSend)
    end
end
