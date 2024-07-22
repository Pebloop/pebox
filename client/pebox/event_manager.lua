local EventManager = {}

local Command = require("pebox.models.command")
local EventsCommands = require("pebox.events_commands")

local id = os.getComputerID()

local function manage_commands(message, gameData)
    local command = Command:new({}, message)
    if command.id ~= id then
        return gameData
    end
    return EventsCommands[command.command](command, gameData)
end

function EventManager.execute(event, message, gameData)
    if event == "modem_message" then
        gameData = manage_commands(message, gameData)
    end
    return gameData
end

return EventManager