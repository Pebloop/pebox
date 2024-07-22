local EventsCommands = {}

local Player = require("pebox.models.player")
local ServerCommands = require("pebox.server_commands")
local HomeScreen = require("pebox.screens.home_screen")

local modem = peripheral.find( "modem" )

-- command executed by the client to join the party
local function commandCodeStart(command, gameData)
    if command.args[1] ~= gameData.code then
        ServerCommands.rejectCode(command.id)
        return gameData
    end

    local deviceID = command.id
    local playerName = command.args[2]
    ServerCommands.acceptCode(deviceID)
    local newPlayer = Player:new({id = deviceID, name = playerName})
    table.insert(gameData.players, newPlayer)
    print("Player " .. playerName .. " has joined the game")
    HomeScreen.draw(gameData.players, gameData.code)
    return gameData
end

local function commandPong(command, gameData)
    for _, player in pairs(gameData.players) do
        if player.id == command.id then
            player.keepAlive = os.time()
        end
    end
    return gameData
end

EventsCommands["START_CODE"] = commandCodeStart
EventsCommands["PONG"] = commandPong

return EventsCommands