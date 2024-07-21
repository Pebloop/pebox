function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
 end
 
 local id = os.getComputerID()

local modem = peripheral.find( "modem" )
modem.open( 6 )
io.write("Enter the code: ")
local code = io.read()
modem.transmit( 5, 6, id .. " CODE_START " .. code)

while true do
    local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")

    print(message)
    if string.starts(message, "CODE_ACCEPTED") then
        local clientID = string.sub(message, 15)
        print("Code is correct! Welcome player " .. clientID)
        break
    end
end