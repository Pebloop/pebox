-- Imports --
local PeboxCommands = require("pebox.pebox_commands")
local PeboxCore = require("pebox.pebox_core")
local PeboxUtils = require("pebox.pebox_utils")
local HomeScreen = require("pebox.screens.home_screen")
local EventManager = require("pebox.event_manager")

-- List of all connected clients
local gameData = {
    -- The session code --
    code = PeboxCore.generateaConexionCode(),
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

HomeScreen.draw({}, code)

while true do
    local event, _, _, _, message, _ = os.pullEvent()

    EventManager.execute(event, message, gameData)
    
end