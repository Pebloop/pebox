local PeboxCommands = require("pebox.pebox_commands")
local PeboxCore = require("pebox.pebox_core")

local id = os.getComputerID()
local playerId = -1

local modem = peripheral.find( "modem" )
modem.open( 6 )
io.write("Enter your name: ")
local name = io.read()
io.write("Enter the code: ")
local code = io.read()
PeboxCommands.codeStart(code, name)

while true do
    local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")

    if PeboxCore.id(message) == tostring(id) then
        local command = PeboxCore.command(message)
        if command == "CODE_ACCEPTED" then
            playerId = PeboxCore.args(message)[1]
            print("Code accepted!")
            print("You are player " .. playerId)
            break
        elseif command == "CODE_REJECTED" then
            print("Code rejected! Try Again.")
        end
    end
end

if playerId == 1 then
    print("Press Enter to start the game.")
    io.read()
    PeboxCommands.gameStart(playerId)
end

while true do
    local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")
end