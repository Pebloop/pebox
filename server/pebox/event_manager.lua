local EventManager = {}

local Command = require("pebox.models.command")
local EventsCommands = require("pebox.events_commands")

local function manage_commands(message, gameData)
    local command = Command:new({}, message)
    EventsCommands[command.command](command, gameData)
end

function EventManager.execute(event, message, gameData)
    if event == "modem_message" then
        gameData = manage_commands(message, gameData)
    end
    return gameData
end

return EventManager