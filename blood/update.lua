local path = shell.dir() .. "/"

local function loadFile(url, fileName)
    local code = http.get(url).readAll()
    local file = fs.open(path .. fileName, "w")
    file.write(code)
    file.close()
end

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/blood/start.lua", "start.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/blood/src/redraw.lua", "src/redraw.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/blood/src/manage_events.lua", "src/manage_events.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/blood/src/models/data.lua", "src/models/data.lua")