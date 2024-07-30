local modem = peripheral.find("modem")

modem.open(3)

print("Printer client")
print("1 - print")
print("2 - get ink levels")
print("3 - get paper levels")
local request = io.read()

local function print(content, color)
    modem.transmit(1, 3, { content = content, color = color })

    print("printing...")

    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if channel == 3 then
        print(message)
    end
end

if string.match(request, "1") then
    print("document path")
    local path = io.read()

    if path.find("file:") then
        path = string.sub(path, 6)
    elseif path.find("wb:") then
        print("website print not supported yet")
        return
    end

    local file = fs.open(path, "r")
    local content = file.readAll()
    file.close()

    print("detected format :")
    if content.find("webloop (not supported yet)") then
        print("webloop")
    elseif content.find("doc") then
        print("doc (not supported yet)")
    else
        print("text")
        print("please choose a color to print the page")
        local color = io.read()
        print(content, color)
    end
end
