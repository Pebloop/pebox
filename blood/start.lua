local Redraw = require('src.redraw')
local Data = require('src.models.data')
local ManageEvents = require('src.manage_events')

local wx, wy = term.getSize()
local window = window.create(term.current(), 1, 1, wx, wy)
window.setPaletteColor(1, 0x292929) -- background color
window.setPaletteColor(2, 0xFFFFFF) -- basic text color
window.setPaletteColor(3, 0x4f4f4f) -- 1st elevation color

-- set the window background color
window.setBackgroundColor(1)

local data = Data:new()

-- mai loop
while true do
    if data.isDirty then
        Redraw.exec(window, data)
    end

    local event = {os.pullEvent()}
    ManageEvents.exec(event, window, data)
end