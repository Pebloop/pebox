local PeboxCommands = require("pebox.pebox_commands")
local PeboxCore = require("pebox.pebox_core")

local id = os.getComputerID()

local modem = peripheral.find("modem")
modem.open(6)
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
            print("Code accepted!")
            parallel.waitForAny(gameStart, PeboxCore.keepAlive)
            break
        elseif command == "CODE_REJECTED" then
            print("Code rejected! Try Again.")
        end
    end
end

local function gameStart()

    print("Press Enter to start the game.")
    print("(player 1 only)")
    while true do
        local event, key
        os.pullEvent();
        print(event)
        if event == "key" and key == keys.enter then
            break
        end
    end
    PeboxCommands.gameStart()
    print("starting game")

    while true do
        local event, modemSide, senderChannel,
        replyChannel, message, senderDistance = os.pullEvent("modem_message")
    end
end
