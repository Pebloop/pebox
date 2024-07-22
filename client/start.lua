-- Imports --
local EventManager = require("pebox.event_manager")
local ClientCommands = require("pebox.client_commands")
local ConnectNameScreen = require("pebox.screens.connect_name_screen")
local ConnectCodeScreen = require("pebox.screens.connect_code_screen")

-- Peripherals --
local modem = peripheral.find("modem")

-- Local variables --
-- game data --
local gameData = {
    name = "",
}

if not modem then
    print("No modem attached, exiting")
    return
end

modem.open(6)

ConnectNameScreen.display()
gameData.name  = io.read()
ConnectCodeScreen.display()
local code = io.read()
ClientCommands.startCode(code, gameData.name)

while true do
    local event, _, _, _, message, _ = os.pullEvent()

    EventManager.execute(event, message, gameData)
    
end