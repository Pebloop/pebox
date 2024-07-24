local modem = peripheral.find("modem")
local configsPath = shell.dir().."/configs/"

local configs = {}

for _, file in ipairs(fs.list(configsPath)) do
    if not fs.isDir(configsPath..file) then
        local configFile = fs.open(configsPath..file, "r")
        local config = {}
        for line in configFile.readLine do
            local key, value = line:match("([^=]+)=(.+)")
            config[key] = value
        end
        configFile.close()
        
        print("Loaded config for channel "..config.channel)
        configs[config.channel] = config
        modem.open(tonumber(config.channel))
    end
end

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    local config = configs[tostring(channel)]
    if config then
        if message == 'get' then
            print("Send index page to "..replyChannel)
            local webPage = fs.open(config.path..config.index, "r")
            local content = webPage.readAll()
            webPage.close()
            modem.transmit(replyChannel, channel, content)
        end
    end
end