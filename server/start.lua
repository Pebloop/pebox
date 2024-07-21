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
local PeboxUtils = require("pebox.pebox_utils")
local HomeScreen = require("pebox.screens.home_screen")

local clients = {}
local clientsNames = {}
local nbPlayers = 0
local code = PeboxCore.generateaConexionCode()

print("launching server")

local modem = peripheral.find("modem")
if not modem then
    print("No modem attached, exiting")
    return
end
modem.open(5)

local monitor = peripheral.find("monitor")
if not monitor then
    print("No monitor attached, exiting")
    return
end

HomeScreen.draw({}, code)

function gameStart()
    print("gamestart")
    while true do
        local event, modemSide, senderChannel,
        replyChannel, message, senderDistance = os.pullEvent()

        --print(message)
        if event == "modem_message" then
            if PeboxCore.command(message) == ("CODE_START") then
                if PeboxCore.args(message)[1] == code then
                    local deviceID = PeboxCore.id(message)
                    local playerName = PeboxCore.args(message)[2]

                    print("New player " .. playerName .. " with deviceID " .. deviceID)
                    nbPlayers = PeboxUtils.len(clients) + 1
                    PeboxCommands.acceptCode(PeboxCore.id(message))
                    clientsNames[nbPlayers] = playerName
                    clients[nbPlayers] = PeboxCore.id(message)
                    HomeScreen.draw(clientsNames, code)
                else
                    print("Code is incorrect!")
                    PeboxCommands.rejectCode(PeboxCore.id(message))
                end
            end
        end

        while true do
            local event, modemSide, senderChannel,
            replyChannel, message, senderDistance = os.pullEvent("modem_message")
        end
    end
end

function keepAlive()
    print("keepAlive")
    while true do

        -- Add players as they join
        local event, modemSide, senderChannel,
        replyChannel, message, senderDistance = os.pullEvent()
        if event == 'modem_message' then
            if PeboxCore.command(message) == "CODE_START" and PeboxCore.args(message)[1] == code then
                local playerID = PeboxCore.args(message)[1]
                nbPlayers = PeboxUtils.len(clients) + 1
                clients[nbPlayers] = playerID
                clientsNames[nbPlayers] = PeboxCore.args(message)[2]
            end
        end


        for i = 1, nbPlayers do
            modem.transmit(6, 5, clients[i] .. " KEEP_ALIVE")
            local timer = os.time()
            while os.time() - timer < 3 do
                local event, modemSide, senderChannel,
                replyChannel, message, senderDistance = os.pullEvent()
                if event == "modem_message" then
                    print(message)
                    if PeboxCore.id(message) == clients[i] and PeboxCore.command(message) == "KEEP_ALIVE" then
                        modem.transmit(6, 5, clients[i] .. " KEEP_ALIVE")
                    end
                end
            end
        end
    end
end

parallel.waitForAny(gameStart, keepAlive)