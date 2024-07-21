local PeboxCommands = {}

local PeboxCore = require("pebox.pebox_core")

local modem = peripheral.find( "modem" )

function PeboxCommands.acceptCode(deviceID)
    modem.transmit( 6, 5, deviceID .. " CODE_ACCEPTED")
end

function PeboxCommands.rejectCode(deviceID)
    modem.transmit( 6, 5, deviceID .. " CODE_REJECTED")
end

return PeboxCommands