local path = shell.dir() .. "/"

local function loadFile(url, fileName)
    local code = http.get(url).readAll()
    local file = fs.open(path .. fileName, "w")
    file.write(code)
    file.close()
end

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/client/start.lua", "start.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/client/pebox/client_core.lua", "pebox/client_core.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/client/pebox/event_manager.lua", "pebox/event_manager.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/client/pebox/events_commands.lua", "pebox/events_commands.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/client/pebox/client_commands.lua", "pebox/client_commands.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/client/pebox/models/command.lua", "pebox/models/command.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/client/pebox/screens/connect_name_screen.lua", "pebox/screens/connect_name_screen.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/client/pebox/screens/connect_code_screen.lua", "pebox/screens/connect_code_screen.lua")
