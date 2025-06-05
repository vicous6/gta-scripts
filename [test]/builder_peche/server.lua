RegisterNetEvent('fishing:catchFish')

RegisterNetEvent('fishing:addSpots')

RegisterNetEvent('fishing:getSpots')

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        MySQL.query([[
            CREATE TABLE IF NOT EXISTS fish_job (
                id INT AUTO_INCREMENT PRIMARY KEY,
                x FLOAT NOT NULL,
                y FLOAT NOT NULL,
                z FLOAT NOT NULL
            )
        ]], {}, function(success)
            if not success then
                print("[fish_job] ERROR: Failed to create table")
                return
            end
            print("[fish_job] Table created or already exists.")
        end)
    end
end)

function get_fish_spots(cb)
    MySQL.query('SELECT x, y, z FROM fish_job', {}, function(result)
        if not result then
            print("[fish_job] ERROR: No result from database query!")
            cb({})
            return
        end
        local spots = {}
        for _, row in ipairs(result) do
            table.insert(spots, vector3(row.x, row.y, row.z))
        end
        print("[fish_job] Fetched fishing spots from the database.")
        cb(spots)
    end)
end


AddEventHandler('fishing:getSpots', function()
    local _source = source
    print("[fish_job] Sending fishing spots to player: " .. _source)

    get_fish_spots(function(spots)
        TriggerClientEvent('fishing:sendSpots', _source, spots)
    end)
end)

RegisterNetEvent('fishing:addSpot', function(x, y, z)
    local _source = source
    print("addSpot")
    print(x)
    print(y)
    print(z)
    print(("[fish_job] Adding new fishing spot: X=%.2f, Y=%.2f, Z=%.2f"):format(x, y, z))

    MySQL.query('INSERT INTO fish_job (x, y, z) VALUES (?, ?, ?)', { x, y, z }, function(result)
        if result then
            print("[fish_job] Spot added successfully.")
            -- Optionally notify client
            get_fish_spots(function(spots)
                TriggerClientEvent('fishing:updateNUI', _source, spots)
            end)
        else
            print("[fish_job] Failed to add spot.")
        end
    end)
end)

-- AddEventHandler('fishing:sendSpots', function(spots)
--     TriggerClientEvent('fishing:receiveSpots', _source, spots)
-- end)

-- AddEventHandler('fishing:catchFish', function()
--     local _source = source
--     local fishAmount = math.random(1, 5)

--     -- Give fish item here (integrate with your inventory system)

--     TriggerClientEvent('chat:addMessage', _source, {
--         args = {'Fishing', 'You caught ' .. fishAmount .. ' fish!'}
--     })
-- end)