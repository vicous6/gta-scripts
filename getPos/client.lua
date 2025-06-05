-- Register a client-side command "pos"
local displayPos = false
local positionThread = nil

RegisterCommand("pos", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    if not displayPos then
        displayPos = true
        print("Position display activated")
        
        -- Create thread to continuously display position
        positionThread = Citizen.CreateThread(function()
            while displayPos do
                local currentCoords = GetEntityCoords(PlayerPedId())
                print(("Position: X: %.2f, Y: %.2f, Z: %.2f"):format(
                    currentCoords.x, 
                    currentCoords.y, 
                    currentCoords.z
                ))
                Citizen.Wait(1000) -- Update every second
            end
        end)
    else
        displayPos = false
        if positionThread then
            Citizen.InvokeNative(0x9FBDA379383A52A4, positionThread) -- TerminateThread native
            positionThread = nil
        end
        print("Position display deactivated")
    end
end, false)