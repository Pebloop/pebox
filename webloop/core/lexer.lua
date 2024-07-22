local args = {...}
local filePath = args[1]
local  env = {}

local file = fs.open(shell.dir() .. "/" .. filePath, "r")
local code = loadstring(file.readAll())
file.close()

setfenv(code, env)
pcall(code)