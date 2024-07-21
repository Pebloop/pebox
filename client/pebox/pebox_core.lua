local PeboxCore = {}

local modem = peripheral.find( "modem" )
local id = os.getComputerID()

-- parse the message into parts
local function parseMessage(message)
    local messageParts = {}
    for part in string.gmatch(message, "%S+") do
        table.insert(messageParts, part)
    end
    return messageParts
end

----------------

-- get the command from the message
function PeboxCore.command(message)
    local messageParts = parseMessage(message)
    return messageParts[2]
end


-- get the id from the message
function PeboxCore.id(message)
    local messageParts = parseMessage(message)
    return messageParts[1]
end

-- get the args from the message
function PeboxCore.args(message)
    local messageParts = parseMessage(message)
    local args = {}
    for i = 3, #messageParts do
        table.insert(args, messageParts[i])
    end
    return args
end

function PeboxCore.keepAlive()
    local routine = coroutine.create(function()
        modem.transmit( 5, 6, id .. " KEEP_ALIVE")
        while true do
            local event, modemSide, senderChannel,
            replyChannel, message, senderDistance = os.pullEvent()
            if event == "modem_message" then
                if PeboxCore.id(message) == id then
                    modem.transmit( 5, 6, id .. " KEEP_ALIVE")
                end
            end
        end
    end)
    coroutine.resume(routine)
    return routine
end

return PeboxCore