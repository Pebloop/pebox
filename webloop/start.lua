local Webloop = require("webloop")

local w, h = term.getSize()
local window = window.create(term.current(), 1, 1, w - 2, h - 2)
local webloop = Webloop:new(window)
webloop:navigate("file:".. shell.dir() .. "/example.lua")