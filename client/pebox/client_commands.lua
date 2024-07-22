-- All the commands that the client can send to the server

local Commands = {}

-- peripherals
local modem = peripheral.find( "modem" )

-- cmoputer id
local id = os.getComputerID()

-- local functions
-- send command to the server
local function send(message)
    modem.transmit( 5, 6, id .. " " .. message)
end

-- Commands
-- Send connection attempt to the server
function Commands.startCode(code, playerName)
    send(deviceID, "START_CODE " .. code .. " " .. playerName)
end

function Commands.pong()
    send(id, "PONG")
end

return Commands