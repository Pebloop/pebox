local EventsCommands = {}

local ClientCommands = require("pebox.client_commands")

-- command executed by the client to join the party
local function commandAcceptCode(command, gameData)
    print("connected !")
    return gameData
end

local function commandRejectCode(command, gameData)
    print("rejected !")
    return gameData
end

local function ping(command, gameData)
    ClientCommands.pong()
    return gameData
end

EventsCommands["CODE_ACCEPTED"] = commandAcceptCode
EventsCommands["CODE_REJECTED"] = commandRejectCode
EventsCommands["PING"] = ping

return EventsCommands