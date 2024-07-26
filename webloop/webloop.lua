local WebloopManager = require("core.webloop_manager")

local Webloop = {}

function Webloop:new(window)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    -- setup data
    o.window = window
    return o
end

local function navigateFile(env, filePath)
    local file = fs.open(filePath, "r")

    if not file then
        print("File not found")
        return
    end

    local code = loadstring(file.readAll())
    file.close()

    setfenv(code, env)
    env.webWindow.clear()
    env.webWindow.setCursorPos(1, 1)
    local success, result = pcall(code)
    env.webWindow.clear()
    if not success then
        print(result)
    end
end

local function navigateWeb(env, url)
    local modem = peripheral.find("modem")
    local urlChannel = string.find(url, "/") and string.sub(url, 1, string.find(url, "/") - 1)
    
    local responseChannel = math.random(1, 65535)
    modem.open(responseChannel)

    local response = modem.transmit

    local code = http.get(url).readAll()
    local code = loadstring(code)
    setfenv(code, env)
    env.window.clear()
    env.window.setCursorPos(1, 1)
    local success, result = pcall(code)
    env.window.clear()
    if not success then
        print(result)
    end

    
end

function Webloop:navigate(url)
    local  env = {
        webloop = WebloopManager.execute,
        body = require("elements/body").body,
        text = require("elements/text").text,
        div = require("elements/div").div,
        webWindow = self.window
    }

    if string.match(url, "wb:") then
        navigateWeb(env, string.sub(url, 4))
    elseif string.match(url, "file:") then
        navigateFile(env, string.sub(url, 6))
    end
end

return Webloop