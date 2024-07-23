local path = shell.dir() .. "/"

local function loadFile(url, fileName)
    local code = http.get(url).readAll()
    local file = fs.open(path .. fileName, "w")
    file.write(code)
    file.close()
end

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/start.lua", "start.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/example.lua", "example.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/core/style_manager.lua", "core/style_manager.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/core/webloop_manager.lua", "core/webloop_manager.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/data/elements_list.lua", "data/elements_list.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/data/style_list.lua", "data/style_list.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/elements/body.lua", "elements/body.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/elements/text.lua", "elements/text.lua")

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/begin.lua", "style/begin.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/center.lua", "style/center.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/end.lua", "style/end.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/bg_color.lua", "style/bg_color.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/text_color.lua", "style/text_color.lua")