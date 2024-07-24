local path = shell.dir() .. "/"

local function loadFile(url, fileName)
    local code = http.get(url).readAll()
    local file = fs.open(path .. fileName, "w")
    file.write(code)
    file.close()
end

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/pixie/start.lua", "start.lua")