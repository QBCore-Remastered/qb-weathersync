local state = GlobalState

state.blackout = Config.Blackout

--- Toggles the blackout effect
---@param enabled boolean
local function setBlackout(enabled)
    state.blackout = enabled
end

exports("setBlackout", setBlackout)


