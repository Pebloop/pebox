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

    local content = file.readAll()
    local code = loadstring("return " .. content .. "(getWindow())")
    file.close()

    setfenv(code, env)
    local success, result, t = pcall(code)
    if not success then
        print(result)
    else
        print(success)
        print(result)
        return result
    end
    return nil
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
    local success, result = pcall(code)
    if not success then
        term.clear()
        term.setCursorPos(1, 1)
        print(result)
    else
        print(result)
        return result
    end
    return nil
end

function Webloop:navigate(url)
    local function getWindow()
        return self.window
    end

    local env = {
        webloop = WebloopManager.execute,
        body = require("elements/body").body,
        text = require("elements/text").text,
        div = require("elements/div").div,
        link = require("elements/link").link,
        getWindow = getWindow,
        dir = shell.dir
    }

    local response = nil
    while true do
        if response then
            if response.url then
                url = response.url
            end
        end
        
        if string.match(url, "wb:") then
            response = navigateWeb(env, string.sub(url, 4))
        elseif string.match(url, "file:") then
            response = navigateFile(env, string.sub(url, 6))
        end

        if not response then
            break
        end

    end
    self.window.clear()
    self.window.setCursorPos(1, 1)
end

return Webloop
