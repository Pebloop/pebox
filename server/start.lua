-- received comand format : [playerID|deviceID] [command] [args]
--
-- Receivable Commands:
-- [deviceID] CODE_START [code] : Starts the code verification process
--
-- Sendable Commands:
-- [deviceID] CODE_ACCEPTED [playerID] : Accepts the code
-- [playerID] CODE_REJECTED : Rejects the code

local clients = {}

local modem = peripheral.find( "modem" )
modem.open( 5 )
print(code)

local monitor = peripheral.find("monitor")
monitor.clear()
monitor.write("Enter the code: " )
monitor.setCursorPos(1, 2)
monitor.write(code)

while true do
    local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")

    if command(message) == ("CODE_START ") then
        if args[1] == code then
            print("Code is correct! Welcome player " .. #clients)
            modem.transmit( 6, 5, "CODE_ACCEPTED " .. #clients)
            clients[#clients] = command[1]
        else
            print("Code is incorrect!")
            modem.transmit( 6, 5, "CODE_REJECTED")
        end

        clients[#clients] = command[1]
    end

end