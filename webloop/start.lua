local WebloopManager = require("core.webloop_manager")

local args = {...}
local filePath = args[1]
local  env = {
    webloop = WebloopManager.execute,
    body = require("elements/body").body,
    text = require("elements/text").text,
    div = require("elements/div").div,
}

local file = fs.open(shell.dir() .. "/" .. filePath, "r")
local code = loadstring(file.readAll())
file.close()

setfenv(code, env)
term.clear()
term.setCursorPos(1, 1)
local success, result = pcall(code)
term.clear()
if not success then
    print(result)
end