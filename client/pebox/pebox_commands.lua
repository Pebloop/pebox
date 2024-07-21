local PeboxCommands = {}

local PeboxCore = require("pebox.pebox_core")

local id = os.getComputerID()

function PeboxCommands.codeStart(code, pseudo)
    modem.transmit( 6, 5, id .. " CODE_START " .. code .. " " .. pseudo)
end

function PeboxCommands.gameStart(playerID)
    modem.transmit( 6, 5, playerID .. " GAME_START")
end

return PeboxCommands