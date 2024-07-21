-- All the commands that the server can send to the clients

local PeboxCommands = {}

-- peripherals
local modem = peripheral.find( "modem" )

-- local functions
-- send command to the client
local function send(deviceID, message)
    modem.transmit( 6, 5, deviceID .. " " .. message)
end

-- Commands
-- The client connected to the server with the correct code 
function PeboxCommands.acceptCode(deviceID)
    send(deviceID, "CODE_ACCEPTED")
end

-- The client connected to the server with the wrong code
function PeboxCommands.rejectCode(deviceID)
    send(deviceID , "CODE_REJECTED")
end

return PeboxCommands