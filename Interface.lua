--- VARIABLES-----
BANT.UIUpdateInterval = 0.125;
BANT.DisplayStartTime = "--";
BANT.PlayingSound = 0;
BANT.ParentFrameWidth = 150;
BANT.ParentFrameHeight = 150;
BANT.RowOffset = -20;
BANT.ColOffset = 45;
BANT.Texture_Check = "Interface\\AddOns\\BannerTracker\\img\\checkmark.tga";
BANT.Texture_X = "Interface\\AddOns\\BannerTracker\\img\\xmark.tga";
BANT.Addon_Frame = CreateFrame("Frame", "BANT_AddonFrame", UIParent, "TooltipBorderedFrameTemplate" or nil)

BANT.Addon_Frame:SetHeight(BANT.ParentFrameHeight)
BANT.Addon_Frame:SetPoint("CENTER", 0, 0)
BANT.Addon_Frame:SetWidth(BANT.ParentFrameWidth)
BANT.Addon_Frame.TimeSinceLastUpdate = BANT.UIUpdateInterval
BANT.Addon_Frame:SetMovable(true)

BANT.Title_Frame = CreateFrame("Frame", "BANT_TitleFrame", BANT.Addon_Frame,
                       BackdropTemplateMixin and "BackdropTemplate")
BANT.Title_Frame:EnableMouse(true)
BANT.Title_Frame:RegisterForDrag("LeftButton")

BANT.Title_Frame:SetHeight(30)
BANT.Title_Frame:SetPoint("TOPLEFT", 0, 32)
BANT.Title_Frame:SetWidth(BANT.ParentFrameWidth)
BANT.Title_Frame.texture = BANT.Title_Frame:CreateTexture()
BANT.Title_Frame.texture:SetAllPoints(BANT.Title_Frame)
BANT.Title_Frame:SetScript("OnMouseDown", function(self, button)
    if (not BANT.Addon_Frame.moving and button == "LeftButton") then
        BANT.Addon_Frame:StartMoving()
        BANT.Addon_Frame.moving = true
    end
end)

BANT.Title_Frame:SetScript("OnMouseUp", function(self, button)
    if (BANT.Addon_Frame.moving) then
        BANT.Addon_Frame:StopMovingOrSizing()
        BANT.Addon_Frame.moving = false
    end
end)

BANT.Title_Frame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    edgeSize = 16,
    insets = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4
    }
})

BANT.Addon_Title = BANT.Title_Frame:CreateFontString()
BANT.Addon_Title:SetFont("Fonts\\FRIZQT__.TTF", BANT.FontSize)
BANT.Addon_Title:SetPoint("CENTER", 0, 0)
BANT.Addon_Title:SetText("BANNER TRACKER")

-- Create Panel UI --
BANT.Data_Frame = CreateFrame("Frame", "BANT_DataFrame", BANT.Addon_Frame, "TooltipBorderedFrameTemplate" or nil)
BANT.Data_Frame:SetHeight(BANT.ParentFrameHeight)
BANT.Data_Frame:SetPoint("TOPLEFT", 0, 0)
BANT.Data_Frame:SetWidth(BANT.ParentFrameWidth)
BANT.Data_Frame.texture = BANT.Data_Frame:CreateTexture()
BANT.Data_Frame.texture:SetAllPoints(BANT.Data_Frame)

BANT.Group_Frame = CreateFrame("Frame", "BANT_GroupFrame", BANT.Addon_Frame, nil)
BANT.Group_Frame:SetHeight(BANT.ParentFrameHeight)
BANT.Group_Frame:SetPoint("TOPRIGHT", BANT.Data_Frame, "TOPLEFT", 5, 0)
BANT.Group_Frame:SetWidth(BANT.ParentFrameWidth)

-- Epic Banner Button
local playerColPos = 10;
BANT.EpicBanner_Button = CreateFrame("Button", "Btn_EpicBanner", BANT.Data_Frame, "SecureActionButtonTemplate")
BANT.EpicBanner_Button:SetAttribute("type", "item")
BANT.EpicBanner_Button:SetAttribute("unit", "player")
BANT.EpicBanner_Button:SetAttribute("item", "Battle Standard of Coordination")
BANT.EpicBanner_Button:SetWidth(32);
BANT.EpicBanner_Button:SetHeight(32);
BANT.EpicBanner_Button:SetPoint("TOPLEFT", playerColPos, -10)

BANT.EpicBanner_Button.bg = BANT.EpicBanner_Button:CreateTexture(nil, "OVERLAY")
BANT.EpicBanner_Button.bg:SetAllPoints(true)
BANT.EpicBanner_Button:SetNormalTexture("Interface\\AddOns\\BannerTracker\\img\\BannerEpic.tga");
BANT.EpicBanner_Button:SetHighlightTexture("Interface\\AddOns\\BannerTracker\\img\\Highlight.tga");
BANT.EpicBanner_Button:SetPushedTexture("Interface\\AddOns\\BannerTracker\\img\\BannerEpicPushed.tga");

-- BANT.EpicBanner_Button.cd = CreateFrame("Cooldown", "CD_EpicBanner", BANT.EpicBanner_Button, "CooldownFrameTemplate" or nil);
-- BANT.EpicBanner_Button.cd:SetAllPoints(true);
BANT.EpicBanner_Button:SetScript("OnMouseDown", function(self, button)
    BANT.UpdateCooldownInfo();
    BANT.BroadcastCooldownInfo();
end)

-- Blue Banner Button
playerColPos = playerColPos + BANT.ColOffset;
BANT.BlueBanner_Button = CreateFrame("Button", "Btn_BlueBanner", BANT.Data_Frame, "SecureActionButtonTemplate")
BANT.BlueBanner_Button:SetAttribute("type", "item")
BANT.BlueBanner_Button:SetAttribute("unit", "player")
BANT.BlueBanner_Button:SetAttribute("item", "Standard of Unity")
BANT.BlueBanner_Button:SetWidth(32);
BANT.BlueBanner_Button:SetHeight(32);
BANT.BlueBanner_Button:SetPoint("TOPLEFT", playerColPos, -10)
BANT.BlueBanner_Button.bg = BANT.BlueBanner_Button:CreateTexture(nil, "OVERLAY")
BANT.BlueBanner_Button.bg:SetAllPoints(true)
BANT.BlueBanner_Button:SetNormalTexture("Interface\\AddOns\\BannerTracker\\img\\BannerBlue.tga");
BANT.BlueBanner_Button:SetHighlightTexture("Interface\\AddOns\\BannerTracker\\img\\Highlight.tga");
BANT.BlueBanner_Button:SetPushedTexture("Interface\\AddOns\\BannerTracker\\img\\BannerBluePushed.tga");
BANT.BlueBanner_Button:SetScript("OnMouseDown", function(self, button)
    BANT.UpdateCooldownInfo();
    BANT.BroadcastCooldownInfo();
end)

-- Green Banner Button
playerColPos = playerColPos + BANT.ColOffset;
BANT.GreenBanner_Button = CreateFrame("Button", "Btn_GreenBanner", BANT.Data_Frame, "SecureActionButtonTemplate")
BANT.GreenBanner_Button:SetAttribute("type", "item")
BANT.GreenBanner_Button:SetAttribute("unit", "player")
BANT.GreenBanner_Button:SetAttribute("item", "Banner of Cooperation")
BANT.GreenBanner_Button:SetWidth(32);
BANT.GreenBanner_Button:SetHeight(32);
BANT.GreenBanner_Button:SetPoint("TOPLEFT", playerColPos, -10)
BANT.GreenBanner_Button.bg = BANT.GreenBanner_Button:CreateTexture(nil, "OVERLAY")
BANT.GreenBanner_Button.bg:SetAllPoints(true)
BANT.GreenBanner_Button:SetNormalTexture("Interface\\AddOns\\BannerTracker\\img\\BannerGreen.tga");
BANT.GreenBanner_Button:SetHighlightTexture("Interface\\AddOns\\BannerTracker\\img\\Highlight.tga");
BANT.GreenBanner_Button:SetPushedTexture("Interface\\AddOns\\BannerTracker\\img\\BannerGreenPushed.tga");
BANT.GreenBanner_Button:SetScript("OnMouseDown", function(self, button)
    BANT.UpdateCooldownInfo();
    BANT.BroadcastCooldownInfo();
end)

BANT.partyList = {}

local loaded = false;
local function initialLoad()
    if (not loaded) then
        if (BANT.db.char.showPanel) then
            BANT.Addon_Frame:Show();
        elseif (not BANT.db.char.showPanel) then
            BANT.Addon_Frame:Hide();
        end

        loaded = true;
    end
end

BANT.UIFrameUpdate = CreateFrame("Frame");
function BANT.Func_UIOnUpdate(self, elapsed)
    initialLoad();
    -- OnUpdate
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
    if self.TimeSinceLastUpdate > 0 then
        return
    end
    self.TimeSinceLastUpdate = BANT.UIUpdateInterval
    -- BANT.EpicBanner_Button.cd:SetCooldown(GetTime(), BANT.db.char.epicBanner.cooldown);

    local bannerRank = 0;
    for i = 1, 40 do
        local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal,
            spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, xpAmount =
            UnitAura("player", i)
        if name == "Guild Battle Standard" then
            bannerRank = xpAmount;
            break
        end
    end

    if (bannerRank == 15) then
        BANT.Title_Frame:SetBackdropColor(0.64, 0.21, 0.93); -- purple            
    elseif (bannerRank == 10) then
        BANT.Title_Frame:SetBackdropColor(0, 0.44, 0.86); -- blue         
    elseif (bannerRank == 5) then
        BANT.Title_Frame:SetBackdropColor(0.12, 1, 0); -- green
    else
        BANT.Title_Frame:SetBackdropColor(0, 0, 0); -- green
    end

    for j = 0, 4 do
        local rowPos = -45 + (j * BANT.RowOffset);
        if (BANT.partyList[j] == nil) then
            BANT.partyList[j] = {
                userObj = BANT.Group_Frame:CreateFontString(),
                epicCDObj = BANT.Data_Frame:CreateFontString(),
                epicCDTexture = BANT.Data_Frame:CreateTexture(),
                blueCDObj = BANT.Data_Frame:CreateFontString(),
                blueCDTexture = BANT.Data_Frame:CreateTexture(),
                greenCDObj = BANT.Data_Frame:CreateFontString(),
                greenCDTexture = BANT.Data_Frame:CreateTexture()
            }
        end
        BANT.partyList[j].userObj:SetFont("Fonts\\FRIZQT__.TTF", BANT.FontSize)
        BANT.partyList[j].userObj:SetPoint("TOPRIGHT", -5, rowPos);
        BANT.partyList[j].userObj:SetHeight(32);

        local colPos = 10;
        BANT.partyList[j].epicCDObj:SetFont("Fonts\\FRIZQT__.TTF", BANT.FontSize)
        BANT.partyList[j].epicCDObj:SetPoint("TOPLEFT", colPos, rowPos)
        BANT.partyList[j].epicCDObj:SetJustifyH("CENTER")
        BANT.partyList[j].epicCDObj:SetHeight(32);
        BANT.partyList[j].epicCDObj:SetWidth(32);
        -- BANT.partyList[j].epicCDObj:Hide();
        BANT.partyList[j].epicCDTexture:SetAllPoints(BANT.partyList[j].epicCDObj)
        BANT.partyList[j].epicCDTexture:SetTexture("Interface\\AddOns\\BannerTracker\\img\\checkmark.tga");

        colPos = colPos + BANT.ColOffset;
        BANT.partyList[j].blueCDObj:SetFont("Fonts\\FRIZQT__.TTF", BANT.FontSize)
        BANT.partyList[j].blueCDObj:SetPoint("TOPLEFT", colPos, rowPos)
        BANT.partyList[j].blueCDObj:SetJustifyH("CENTER")
        BANT.partyList[j].blueCDObj:SetHeight(32);
        BANT.partyList[j].blueCDObj:SetWidth(32);
        BANT.partyList[j].blueCDTexture:SetAllPoints(BANT.partyList[j].blueCDObj)
        BANT.partyList[j].blueCDTexture:SetTexture("Interface\\AddOns\\BannerTracker\\img\\checkmark.tga");

        colPos = colPos + BANT.ColOffset;
        BANT.partyList[j].greenCDObj:SetFont("Fonts\\FRIZQT__.TTF", BANT.FontSize)
        BANT.partyList[j].greenCDObj:SetPoint("TOPLEFT", colPos, rowPos)
        BANT.partyList[j].greenCDObj:SetJustifyH("CENTER")
        BANT.partyList[j].greenCDObj:SetHeight(32);
        BANT.partyList[j].greenCDObj:SetWidth(32);
        BANT.partyList[j].greenCDTexture:SetAllPoints(BANT.partyList[j].greenCDObj)
        BANT.partyList[j].greenCDTexture:SetTexture("Interface\\AddOns\\BannerTracker\\img\\checkmark.tga");
    end

    -- get player object data
    BANT.partyList[0].data = BANT.GetPlayerInfoObj();

    -- get group object data
    if IsInGroup() then
        for i = 1, 4 do
            local memberName, realmName = UnitName('party' .. i);
            if (realmName == nil) then
                realmName = GetRealmName();
            end
            local userName = "";
            if (UnitName('party' .. i)) then
                userName = memberName .. "-" .. realmName;
                if (BANT:TableHasKey(BANT.db.char.partyDB, userName)) then
                    BANT.partyList[i].data = BANT.db.char.partyDB[userName];
                end
            end
        end
    end

    -- use consolidated list to set data to objects.
    for i = 0, 4 do
        local data = BANT.partyList[i].data;
        BANT.partyList[i].epicCDTexture:Hide();
        BANT.partyList[i].blueCDTexture:Hide();
        BANT.partyList[i].greenCDTexture:Hide();
        if (data ~= nil) then

            local userName, _ = strsplit("-", data.userName);
            BANT.partyList[i].userObj:SetText(userName)
            if BANT.partyList[i].data == nil then
                BANT.partyList[i].epicCDObj:SetText("-");
                BANT.partyList[i].epicCDTexture:Hide();
                BANT.partyList[i].blueCDObj:SetText("-");
                BANT.partyList[i].blueCDTexture:Hide();
                BANT.partyList[i].greenCDObj:SetText("-");
                BANT.partyList[i].greenCDTexture:Hide();
            else
                -- EPIC
                if (BANT:tobool(data.epicBanner.hasItem) == false) then
                    BANT.partyList[i].epicCDObj:Show();
                    BANT.partyList[i].epicCDTexture:Hide();
                    BANT.partyList[i].epicCDObj:SetText("X");
                else
                    if (tonumber(data.epicBanner.startTime) > 0) then
                        BANT.partyList[i].epicCDObj:Show();
                        BANT.partyList[i].epicCDTexture:Hide();
                        BANT.partyList[i].epicCDObj:SetText(BANT.GetBannerCooldownDisplayText(data.epicBanner));
                    else
                        BANT.partyList[i].epicCDObj:Hide();
                        BANT.partyList[i].epicCDTexture:Show();
                    end
                end
                -- BLUE
                if (BANT:tobool(data.blueBanner.hasItem) == false) then
                    BANT.partyList[i].blueCDObj:Show();
                    BANT.partyList[i].blueCDTexture:Hide();
                    BANT.partyList[i].blueCDObj:SetText("X");
                else
                    if (tonumber(data.blueBanner.startTime) > 0) then
                        BANT.partyList[i].blueCDObj:Show();
                        BANT.partyList[i].blueCDTexture:Hide();
                        BANT.partyList[i].blueCDObj:SetText(BANT.GetBannerCooldownDisplayText(data.blueBanner));
                    else
                        BANT.partyList[i].blueCDObj:Hide();
                        BANT.partyList[i].blueCDTexture:Show();
                    end
                end

                -- GREEN
                if (BANT:tobool(data.greenBanner.hasItem) == false) then
                    BANT.partyList[i].greenCDObj:Show();
                    BANT.partyList[i].greenCDTexture:Hide();
                    BANT.partyList[i].greenCDObj:SetText("X");
                else
                    if (tonumber(data.greenBanner.startTime) > 0) then
                        BANT.partyList[i].greenCDObj:Show();
                        BANT.partyList[i].greenCDTexture:Hide();
                        BANT.partyList[i].greenCDObj:SetText(BANT.GetBannerCooldownDisplayText(data.greenBanner));
                    else
                        BANT.partyList[i].greenCDObj:Hide();
                        BANT.partyList[i].greenCDTexture:Show();
                    end
                end
            end
        end
    end
end

-- Scripts

BANT.Addon_Frame:SetScript("OnUpdate", BANT.Func_UIOnUpdate)
