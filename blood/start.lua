local Redraw = require('src.redraw')

local isDirty = true
local wx, wy = term.getSize()
local window = window.create(term.current(), 1, 1, wx, wy)

-- mai loop
while true do
    if isDirty then
        Redraw.exec(window)
    end

    local event = {os.pullEvent()}
end