local fishingSpots = {}  -- This should be updated from server when player joins

-- Example: receive fishing spots from server (you need to trigger this on player spawn)
RegisterNetEvent('fishing:sendSpots')
RegisterNetEvent('fishing:updateNUI')

RegisterNUICallback("addSpot", function()
    local ped = PlayerPedId() -- Get the player's ped ID
    local pedPosition = GetEntityCoords(ped) -- Get the player's position (x, y, z)
    
    -- Trigger server event to add a new fishing spot
    TriggerServerEvent('fishing:addSpot', pedPosition.x, pedPosition.y, pedPosition.z)
    print(("Added fishing spot at X: %.2f, Y: %.2f, Z: %.2f"):format(pedPosition.x, pedPosition.y, pedPosition.z))
end)

AddEventHandler('playerSpawned', function()
    -- Trigger your custom event here
    TriggerServerEvent('fishing:getSpots')
    print("Player spawned, get fishing spot.")
end)

AddEventHandler('fishing:sendSpots', function(spots)
    print(#spots)
    fishingSpots = spots
    print("Received fishing spots from server:")
    if #spots > 0 then
        for k, v in pairs(fishingSpots) do
            print("x")
            print(("Fishing Spot %d: X: %.2f, Y: %.2f, Z: %.2f"):format(k, v.x, v.y, v.z))
        end
    else
        print("No fishing spots available.")
    end
end)

AddEventHandler('fishing:updateNUI', function(spots)
    print(#spots)
    fishingSpots = spots
    print("Received fishing spots from server:")
    if #spots > 0 then
        for k, v in pairs(fishingSpots) do
            print("x")
            print(("Fishing Spot %d: X: %.2f, Y: %.2f, Z: %.2f"):format(k, v.x, v.y, v.z))
        end
    print("showui command triggered") 
    SetNuiFocus(true, true)
    TriggerServerEvent('fishing:getSpots')
    Citizen.Wait(1000) -- Wait for 1 second
    print("front")
    print(json.encode(fishingSpots))
    print("front")
    SendNUIMessage({ type = "showUI",positions = fishingSpots })
    else
        print("No fishing spots available.")
    end
end)


RegisterCommand("showUi", function()
    print("showui command triggered") 
    SetNuiFocus(true, true)
    
    
    TriggerServerEvent('fishing:getSpots')
    Citizen.Wait(1000) -- Wait for 1 second
    print("front")
    print(json.encode(fishingSpots))
    print("front")
    SendNUIMessage({ type = "showUI",positions = fishingSpots })
  end)


  RegisterNUICallback("closeUI", function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ type = "hideUI" })
    cb({})
  end)
  