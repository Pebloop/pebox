-- received comand format : [playerID|deviceID] [command] [args]
--
-- Receivable Commands:
-- [deviceID] CODE_START [code] : Starts the code verification process
--
-- Sendable Commands:
-- [deviceID] CODE_ACCEPTED [playerID] : Accepts the code
-- [playerID] CODE_REJECTED : Rejects the code

local PeboxCommands = require("pebox.pebox_commands")
local PeboxCore = require("pebox.pebox_core")
local HomeScreen = require("pebox.screens.home_screen")

local clients = {}
local clientsNames = {}
local nbPlayers = 0
local code = PeboxCore.generateaConexionCode()

print("launching server")

local modem = peripheral.find( "modem" )
if not modem then
    print( "No modem attached, exiting" )
    return
end
modem.open( 5 )

local monitor = peripheral.find("monitor")
if not monitor then
    print("No monitor attached, exiting")
    return
end

HomeScreen.draw({}, code)

while true do
    local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")

    --print(message)
    if PeboxCore.command(message) == ("CODE_START") then
        if PeboxCore.args(message)[1] == code then
            local deviceID = PeboxCore.id(message)
            local playerName = PeboxCore.args(message)[2]

            print("New player " .. playerName .. " with deviceID " .. deviceID)
            nbPlayers = nbPlayers + 1
            PeboxCommands.acceptCode(PeboxCore.id(message), nbPlayers)
            clientsNames[nbPlayers] = playerName
            clients[nbPlayers] = PeboxCore.id(message)
            HomeScreen.draw(clientsNames, code)
        else
            print("Code is incorrect!")
            PeboxCommands.rejectCode(PeboxCore.id(message))
        end

    elseif PeboxCore.command(message) == ("GAME_START") then
        if PeboxCore.id(message) == "0" then
            monitor.clear()
            monitor.setCursorPos(monitorW / 2 - 8, monitorH / 2)
            monitor.write("Game is starting!")
            break
        else 
            print("Only player 0 can start the game!")
        end
    end

end

while true do
    local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")
end