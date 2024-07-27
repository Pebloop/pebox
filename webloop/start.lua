local Webloop = require("webloop")

local w, h = term.getSize()
term.clear()
local window = window.create(term.current(), 1, 1, w, h)
local webloop = Webloop:new(window)
webloop:navigate("file:".. shell.dir() .. "/example.lua")