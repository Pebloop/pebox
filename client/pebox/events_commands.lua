local EventsCommands = {}

local ClientCommands = require("pebox.client_commands")

-- command executed by the client to join the party
local function commandAcceptCode(command, gameData)
    print("connected !")
end

local function commandRejectCode(command, gameData)
    print("rejected !")
end

EventsCommands["CODE_ACCEPTED"] = commandAcceptCode
EventsCommands["CODE_REJECTED"] = commandRejectCode

return EventsCommands