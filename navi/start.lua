local modem = peripheral.find("modem")
local channel = math.random(1, 65535)

modem.open(channel)

local request = tonumber(io.read())

modem.transmit(request, channel, "get")

local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")

term.clear()
local file = fs.open(shell.dir().."/tmp/index.lua", "w")
file.write(message)
file.close()

-- exec webloop
shell.run("webloop/start.lua", "tmp/index.lua")