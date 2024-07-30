local modem = peripheral.find("modem")
local printers = require('config')

modem.open(1)
modem.open(2)

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if channel == 1 then
        print("Printer request received")
    elseif channel == 2 then
        print("Printer turtle message received")
    end
end