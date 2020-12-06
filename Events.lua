BANT.MsgPrefix = "BANNERTRACKER";
local function BANT_Events_OnEvent(self, event, ...)

    if event == "PLAYER_LOGIN" then
        C_ChatInfo.RegisterAddonMessagePrefix(BANT.MsgPrefix);
        BANT.db.char.partyDB = {};
    elseif event == "CHAT_MSG_ADDON" then

        local prefix, msg, channel, sender, _ = ...

        if BANT:PlayerSentMessage(sender) then
            return;
        elseif prefix == "BANNERTRACKER" then
            local data = BANT:fromCSV(msg);

            local parsedData = {
                userName = data[1],
                epicBanner = {
                    hasItem = data[2],
                    startTime = data[3],
                    cdLength = data[4]
                },
                blueBanner = {
                    hasItem = data[5],
                    startTime = data[6],
                    cdLength = data[7]
                },
                greenBanner = {
                    hasItem = data[8],
                    startTime = data[9],
                    cdLength = data[10]
                }
            }
            BANT.db.char.partyDB[parsedData.userName] = parsedData;
        end
    elseif event == "GROUP_ROSTER_UPDATE" then
        for k, v in pairs(BANT.partyList) do
            BANT.partyList[k].data = nil;
            BANT.partyList[k].userObj:SetText("");
            BANT.partyList[k].epicCDObj:SetText("");
            BANT.partyList[k].blueCDObj:SetText("")
            BANT.partyList[k].greenCDObj:SetText("")
        end
    end
end

-- Events
BANT.CoreFrame = CreateFrame("frame");
-- Set Event Scripts
BANT.CoreFrame:SetScript("OnEvent", BANT_Events_OnEvent)
-- Register Events
BANT.CoreFrame:RegisterEvent("CHAT_MSG_ADDON");
BANT.CoreFrame:RegisterEvent("PLAYER_LOGIN")
BANT.CoreFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
