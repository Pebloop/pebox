local w, h = term.getSize()
local window = window.create(term.current(), 1, 1, w, h)
Webloop.readFile("example.lua", window)