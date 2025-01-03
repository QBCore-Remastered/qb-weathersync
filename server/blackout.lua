local state = GlobalState

state.blackout = Config.Blackout

--- Toggles the blackout effect
---@param enabled boolean
function SetBlackout(enabled)
    state.blackout = enabled
end

exports("setBlackout", SetBlackout)


