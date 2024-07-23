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

loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_white.lua", "style/backgrounds/bg_white.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_black.lua", "style/backgrounds/bg_black.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_orange.lua", "style/backgrounds/bg_orange.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_magenta.lua", "style/backgrounds/bg_magenta.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_cyan.lua", "style/backgrounds/bg_cyan.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_green.lua", "style/backgrounds/bg_green.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_red.lua", "style/backgrounds/bg_red.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_blue.lua", "style/backgrounds/bg_blue.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_yellow.lua", "style/backgrounds/bg_yellow.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_purple.lua", "style/backgrounds/bg_purple.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_gray.lua", "style/backgrounds/bg_gray.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_light_gray.lua", "style/backgrounds/bg_light_gray.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_brown.lua", "style/backgrounds/bg_brown.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_lime.lua", "style/backgrounds/bg_lime.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_pink.lua", "style/backgrounds/bg_pink.lua")
loadFile("https://raw.githubusercontent.com/Pebloop/pebox/main/webloop/style/backgrounds/bg_light_blue.lua", "style/backgrounds/bg_light_blue.lua")
