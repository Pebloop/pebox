local WebloopManager = require("core.webloop_manager")

local Webloop = {}

local  env = {
    webloop = WebloopManager.execute,
    body = require("elements/body").body,
    text = require("elements/text").text,
    div = require("elements/div").div,
}

function Webloop.readString(code, window)
    setfenv(code, env)
    window.clear()
    window.setCursorPos(1, 1)
    local success, result = pcall(code, window)
    window.clear()
    if not success then
        print(result)
    end
end

function Webloop.readFile(filePath, window)
    local file = fs.open(shell.dir() .. "/" .. filePath, "r")
    local code = loadstring(file.readAll())
    file.close()
    Webloop.readString(code, window)
end

return Webloop