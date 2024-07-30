local Redraw = require('src.redraw')
local Data = require('src.models.data')
local ManageEvents = require('src.manage_events')
local Colors = require('src.data.colors')

local wx, wy = term.getSize()
local window = window.create(term.current(), 1, 1, wx, wy)
local codeWindow = window.create(window, 1, 2, wx, wy - 1)
window.setPaletteColor(Colors.background, 0x292929) -- background color
window.setPaletteColor(Colors.text, 0xFFFFFF) -- basic text color
window.setPaletteColor(Colors.firstElevation, 0x4f4f4f) -- 1st elevation color

-- set the window background color
window.setBackgroundColor(1)

local data = Data:new(codeWindow)

-- mai loop
while true do
    if data.isDirty then
        Redraw.exec(window, data)
    end

    local event = {os.pullEvent()}
    ManageEvents.exec(event, window, data)

    if data.exit then
        break
    end
end

-- cleanup
window.setPaletteColor(colors.white, 0xF0F0F0)
window.setPaletteColor(colors.orange, 0xF2B233)
window.setPaletteColor(colors.magenta, 0xE57FD8)
window.setBackgroundColor(colors.black)
window.setTextColor(colors.white)
window.clear()
