RegisterCommand("rock", function()
    local ped = PlayerPedId()
    
    -- Clear any existing tasks first to avoid conflicts
    ClearPedTasks(ped)
    
    -- Start the Rock animation (looped)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PAPARAZZI", 3, true)
    
    TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            args = {"You played ROCK!"}
        })
end, false)