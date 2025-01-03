local state = GlobalState

state.blackout = Config.Blackout

function SetBlackout(enabled)
    state.blackout = enabled
end

exports("setBlackout", SetBlackout)

AddStateBagChangeHandler("blackout", nil, function(_, _, value, _, replicated)
    print("Blackout changed to: ", value)
end)