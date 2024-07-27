local Webloop = require("webloop")

local w, h = term.getSize()
term.clear()
local window = window.create(term.current(), 1, 5, w - 15, h - 4)
local webloop = Webloop:new(window)
webloop:navigate("file:".. shell.dir() .. "/example.lua")