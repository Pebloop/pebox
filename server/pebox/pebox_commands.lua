local PeboxCommands = {}

local PeboxCore = require(shell.dir() .. ".pebox_core")

function PeboxCommands.acceptCode(deviceID, playerID)
    modem.transmit( 6, 5, deviceID .. " CODE_ACCEPTED " .. playerID)
end