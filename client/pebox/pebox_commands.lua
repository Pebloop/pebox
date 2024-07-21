local PeboxCommands = {}

local PeboxCore = require("pebox.pebox_core")

local id = os.getComputerID()
local modem = peripheral.find( "modem" )

function PeboxCommands.codeStart(code, pseudo)
    modem.transmit( 5, 6, id .. " CODE_START " .. code .. " " .. pseudo)
end

function PeboxCommands.gameStart(playerID)
    modem.transmit( 5, 6, playerID .. " GAME_START")
end

return PeboxCommands