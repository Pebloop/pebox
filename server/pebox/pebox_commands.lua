local PeboxCommands = {}

local PeboxCore = require("pebox.pebox_core")

function PeboxCommands.acceptCode(deviceID, playerID)
    modem.transmit( 6, 5, deviceID .. " CODE_ACCEPTED " .. playerID)
end

function PeboxCommands.rejectCode(deviceID)
    modem.transmit( 6, 5, deviceID .. " CODE_REJECTED")
end

return PeboxCommands