local Webloop = require("webloop")

local w, h = term.getSize()
term.clear()
local window = window.create(term.current(), 2, 2, w - 10, h - 2)
local webloop = Webloop:new(window)
webloop:navigate("file:".. shell.dir() .. "/example.lua")
term.clear()