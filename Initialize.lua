BANT = LibStub("AceAddon-3.0"):NewAddon("BannerTracker", "AceConsole-3.0", "AceEvent-3.0")

local options = {
    name = "Banner Tracker",
    handler = BANT,
    type = 'group',
    args = {
        general_group = {
            type = "group",
            name = "General",
            inline = true,
            order = 1,
            args = {
                general_minimapButton = {
                    type = 'toggle',
                    order = 1,
                    name = 'Minimap Button',
                    desc = "Show minimap button.",
                    set = function(info, val)
                        BANT.db.profile.minimap.hide = not val
                        if (val) then
                            BANT.minimapButton:Show("Banner Tracker");
                        else
                            BANT.minimapButton:Hide("Banner Tracker");
                        end
                    end,
                    get = function(info)
                        return not BANT.db.profile.minimap.hide
                    end
                }
            }
        }
    }
}

local defaults = {
    profile = {
        minimap = {
            hide = false
        }
    },
    char = {
        partyDB = {
            ["*"] = {
                userName = "??",
                epicBanner = {
                    hasItem = 0,
                    startTime = 0,
                    cdLength = 0
                },
                blueBanner = {
                    hasItem = 0,
                    startTime = 0,
                    cdLength = 0
                },
                greenBanner = {
                    hasItem = 0,
                    startTime = 0,
                    cdLength = 0
                }
            }
        },
        userName = "??",
        epicBanner = {
            hasItem = 0,
            startTime = 0,
            cdLength = 0
        },
        blueBanner = {
            hasItem = 0,
            startTime = 0,
            cdLength = 0
        },
        greenBanner = {
            hasItem = 0,
            startTime = 0,
            cdLength = 0
        }
    }
}

---- Functions ----
--- MINIMAP BUTTON ---
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Banner Tracker", {
    type = "data source",
    text = "Banner Tracker",
    icon = "Interface\\Addons\\BannerTracker\\BANTIcon",
    OnTooltipShow = function(tooltip)
        tooltip:SetText("Banner Tracker")
        tooltip:AddLine("Left click to goggle show/hide.", 1, 1, 1)
        tooltip:AddLine("Right to open options.", 1, 1, 1)
        tooltip:Show()
    end,
    OnClick = function(self, button, down)

        if button == "RightButton" then
            if InterfaceOptionsFrame:IsVisible() then
                InterfaceOptionsFrame:Hide()
            else
                InterfaceOptionsFrame:Show()
                InterfaceOptionsFrame_OpenToCategory(BANT.optionPanel)
            end
        else
            BANT.db.char.showPanel = not BANT.db.char.showPanel;
            if (BANT.db.char.showPanel) then
                BANT.Addon_Frame:Show();
            elseif (not BANT.db.char.showPanel) then
                BANT.Addon_Frame:Hide();
            end
        end

    end
})
BANT.minimapButton = LibStub("LibDBIcon-1.0", true)
function BANT:OnInitialize()
    BANT.db = LibStub("AceDB-3.0"):New("BannerTrackerDB", defaults)
    local parent = LibStub("AceConfig-3.0"):RegisterOptionsTable("BannerTracker", options)
    BANT.optionPanel = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("BannerTracker", "Banner Tracker")
    profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(BANT.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("BannerTracker.profiles", profiles)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("BannerTracker.profiles", "Profiles", "Banner Tracker")
    BANT.minimapButton:Register("Banner Tracker", LDB, BANT.db.profile.minimap)

    local playerName = GetUnitName("player");
    local realmName = GetRealmName();
    BANT.db.char.userName = playerName .. "-" .. realmName;
end

function BANT:OnEnable()
    BANT:RegisterChatCommand("BANT", "ProcessSlash")
    StaticPopupDialogs["BANT_SessionPrompt"] = {
        text = "Do you want to restart your session?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            BANT:NewSession(false)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 4 -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }
end
