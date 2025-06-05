-- Register a client-side command "ping"
RegisterCommand("ping", function()
    print("pong") -- Console message
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 255},
        args = {"PingTest", "pong"} -- In-game chat message
    })
end, false)
