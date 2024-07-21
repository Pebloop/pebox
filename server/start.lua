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

local clients = {}
local clientsNames = {}
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

local monitorW, monitorH = monitor.getSize()
monitor.clear()
monitor.setCursorPos(monitorW / 2 - 2, monitorH / 2 - 3)
monitor.write("Pebox" )
monitor.setCursorPos(monitorW / 2 - 2,monitorH / 2)
monitor.write(code)
for i = 1, 8 do
    monitor.setCursorPos(1, monitorH - 9 + i)
    monitor.write(i .. ":")
end

while true do
    local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")

    if PeboxCore.command(message) == ("CODE_START") then
        if PeboxCore.args(message)[1] == code then
            print("Code is correct! Welcome player " .. #clients)
            PeboxCommands.acceptCode(PeboxCore.id(message), #clients)
            clientsNames[#clients] = PeboxCore.args(message)[2]
            monitor.setCursorPos(3, monitorH - 9 + #clients)
            monitor.write(clientsNames[#clients])
            clients[#clients] = PeboxCore.id(message)

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