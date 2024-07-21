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

while true do
    local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")

    if PeboxCore.command(message) == ("CODE_START ") then
        if PeboxCore.args(message)[1] == code then
            print("Code is correct! Welcome player " .. #clients)
            PeboxCommands.acceptCode(PeboxCore.id(message), #clients)
            clients[#clients] = PeboxCore.id(message)
        else
            print("Code is incorrect!")
            modem.transmit( 6, 5, "CODE_REJECTED")
        end

        clients[#clients] = command[1]
    end

end