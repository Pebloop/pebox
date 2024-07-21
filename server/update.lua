local path = shell.dir() .. "/"

local function loadFile(url, fileName)
    local code = http.get(url).readAll()
    local file = fs.open(path .. fileName, "w")
    file.write(code)
    file.close()
end

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/start.lua", "start.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/pebox/server_utils.lua", "pebox/server_utils.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/pebox/server_core.lua", "pebox/server_core.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/pebox/server_commands.lua", "pebox/server_commands.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/pebox/events_commands.lua", "pebox/events_commands.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/pebox/event_manager.lua", "pebox/event_manager.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/pebox/screens/home_screen.lua", "pebox/screens/home_screen.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/pebox/models/command.lua", "pebox/models/command.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/server/pebox/models/player.lua", "pebox/models/player.lua")