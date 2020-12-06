-- file to communicate with other installed addons.

BANT.CommsUpdateInterval = 1;
BANT.Comms_Frame_Hidden = CreateFrame("Frame", "BANT_CommsFrame", UIParent, "TooltipBorderedFrameTemplate" or nil)
BANT.Comms_Frame_Hidden.TimeSinceLastUpdate = BANT.CommsUpdateInterval;

function BANT.Func_Comms_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
    if self.TimeSinceLastUpdate > 0 then
        return
    end
    self.TimeSinceLastUpdate = BANT.CommsUpdateInterval

    BANT.BroadcastCooldownInfo();
end

BANT.Comms_Frame_Hidden:SetScript("OnUpdate", BANT.Func_Comms_OnUpdate)

