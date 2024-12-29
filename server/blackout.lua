local state = GlobalState

state.blackout = Config.Blackout

local function setBlackout(enabled)
    state.blackout = enabled
end

exports("setBlackout", setBlackout)

AddStateBagChangeHandler("blackout", nil, function(_, _, value, _, replicated)
    print("Blackout changed to: ", value)
end)

RegisterCommand("blackout", function(source, args)
    local enable = args[1] == "true" or args[1] == "1" or false
    setBlackout(enable)
end, true)