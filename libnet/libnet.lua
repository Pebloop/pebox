local libnet = {}

local function idToBytes(id)
    if id == nil then
        id = os.getComputerID()
    end
    -- convert id to hex
    local hex = string.format("%x", id)
    -- add 0 to ensure 8 digits
    while string.len(hex) < 8 do
        hex = "0" .. hex
    end

    -- convert each 4 byte to decimal
    local bytes = {}
    for i = 1, 8, 2 do
        local byte = string.sub(hex, i, i + 1)
        table.insert(bytes, tonumber(byte, 16))
    end

    return bytes
end

local function portToBytes(port)
    -- convert port to hex
    local hex = string.format("%x", port)

    -- add 0 to ensure 4 digits
    while string.len(hex) < 4 do
        hex = "0" .. hex
    end

    local bytes = {}
    for i = 1, 4, 2 do
        local byte = string.sub(hex, i, i + 1)
        table.insert(bytes, tonumber(byte, 16))
    end

    return bytes
end

function libnet.getReadableAddress(port, id)
    if id == nil then
        id = os.getComputerID()
    end
    local bytes = idToBytes(id)
    local portBytes = portToBytes(port)
    local address = ""
    for i, byte in ipairs(bytes) do
        address = address .. string.format("%02i", byte)
        address = address .. "."
    end
    for i, byte in ipairs(portBytes) do
        address = address .. string.format("%02i", byte)
        if i < 2 then
            address = address .. "."
        end
    end
    return address
end

function libnet.getChannel(id)
    local bytes = idToBytes(id)
    local channel = ""
    for i, byte in ipairs(bytes) do
        channel = channel .. string.format("%02x", byte)
    end
    return channel
end

function libnet.getAdress(port)

end

return libnet