local PeboxCore = {}

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

-- generate a random code to join the game
function PeboxCore.generateaConexionCode()
    local code = ""
    for i = 1, 5 do
        code = code .. math.random(0, 9)
    end
    return code
end

function PeboxCore.keepAlive(playerID, onDisconnect)
    local routine = coroutine.create(function()
        while true do
            os.sleep(5)
            modem.transmit( 6, 5, playerID .. " KEEP_ALIVE")
            local timer = os.time()
            while os.time() - timer < 5 do
                local event, modemSide, senderChannel,
                replyChannel, message, senderDistance = os.pullEvent("modem_message")
                if PeboxCore.id(message) == playerID then
                    print(message)
                end
            end
            print("Player " .. playerID .. " has disconnected.")
            onDisconnect()
            break
        end
    end)
    coroutine.resume(routine)
    return routine
end

return PeboxCore