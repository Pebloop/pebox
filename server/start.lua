-- Imports --
local Core = require("pebox.server_core")
local EventManager = require("pebox.event_manager")
local ServerCommands = require("pebox.server_commands")
local HomeScreen = require("pebox.screens.home_screen")

-- List of all connected clients
local gameData = {
    -- The session code --
    code = Core.generateaConexionCode(),
    -- The connected players --
    players = {}
}

-- The modem (mandatory)
local modem = peripheral.find("modem")
-- The monitor (mandatory)
local monitor = peripheral.find("monitor")

print("launching server")

if not modem then
    print("No modem attached, exiting")
    return
end

if not monitor then
    print("No monitor attached, exiting")
    return
end

modem.open(5)

HomeScreen.draw({}, gameData.code)

while true do
    local event, _, _, _, message, _ = os.pullEvent()
    
    for _, player in pairs(gameData.players) do
        ServerCommands.ping(player.id)

        if os.time() - player.keepAlive > 0.2 then
            print("Player " .. player.name .. " has disconnected")
            table.remove(gameData.players, _)
            HomeScreen.draw(gameData.players, gameData.code)
        end

    end

    EventManager.execute(event, message, gameData)
    
end