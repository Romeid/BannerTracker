-- This is still needed in case people use their own buttons and not the built in ones.
BANT.CalcEvents_UpdateInterval = 1;

local function BANT_CalcEvents_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - elapsed
    if self.TimeSinceLastUpdate > 0 then
        return
    end
    self.TimeSinceLastUpdate = BANT.CalcEvents_UpdateInterval
    
    BANT.UpdateCooldownInfo();
end

-- Events
BANT.CalcEventsFrame = CreateFrame("frame");
BANT.CalcEventsFrame.TimeSinceLastUpdate = BANT.CalcEvents_UpdateInterval;
-- Set Event Scripts
BANT.CalcEventsFrame:SetScript("OnUpdate", BANT_CalcEvents_OnUpdate)