-- All the commands that the client can send to the server

local Commands = {}

-- peripherals
local modem = peripheral.find( "modem" )

-- local functions
-- send command to the server
local function send(deviceID, message)
    modem.transmit( 5, 6, deviceID .. " " .. message)
end

-- Commands
-- Send connection attempt to the server
function Commands.startCode(deviceID, code, playerName)
    send(deviceID, "START_CODE " .. code .. " " .. playerName)
end

return Commands