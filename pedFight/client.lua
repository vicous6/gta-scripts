-- Register a client-side command "pos"



RegisterCommand("fight", function()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

    -- Load the ped model first
    local model = GetHashKey("g_m_y_famca_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
    for i = 1, 20 do 
    -- Spawn both NPCs

        local ped1 = CreatePed(4, model, pos.x, pos.y - 50.0, pos.z, heading, false, true)
        local ped2 = CreatePed(4, model, pos.x, pos.y + 50.0, pos.z, heading, false, true)


        GiveWeaponToPed(ped1, GetHashKey("weapon_revolver"), 1, false, true)
        GiveWeaponToPed(ped2, GetHashKey("weapon_revolver"), 1, false, true)

        TaskCombatPed(ped2, ped1, 0, 16)
    end
end, false)