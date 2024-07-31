local Redraw = require('src.redraw')
local Data = require('src.models.data')
local ManageEvents = require('src.manage_events')
local Colors = require('src.data.colors')

term.setPaletteColor(Colors.background, 0x292929) -- background color
term.setPaletteColor(Colors.text, 0xFFFFFF) -- basic text color
term.setPaletteColor(Colors.firstElevation, 0x4f4f4f) -- 1st elevation color
term.setPaletteColor(Colors.text2, 0x00FF00) -- 2nd text color

local wx, wy = term.getSize()
local mainWindow = window.create(term.current(), 1, 1, wx, wy)
local codeWindow = window.create(mainWindow, 1, 2, wx, wy - 1)

-- set the window background color
mainWindow.setBackgroundColor(1)
codeWindow.setCursorBlink(true)

local data = Data:new(codeWindow)

-- mai loop
while true do
    if data.isDirty then
        Redraw.exec(mainWindow, data)
    end

    local event = {os.pullEvent()}
    ManageEvents.exec(event, mainWindow, data)

    if data.exit then
        break
    end

    codeWindow.setCursorPos(data.codeCursor.x, data.codeCursor.y)
end

-- cleanup
mainWindow.setPaletteColor(colors.white, 0xF0F0F0)
mainWindow.setPaletteColor(colors.orange, 0xF2B233)
mainWindow.setPaletteColor(colors.magenta, 0xE57FD8)
mainWindow.setPaletteColor(colors.lightBlue, 0x99B2F2)
mainWindow.setBackgroundColor(colors.black)
mainWindow.setTextColor(colors.white)
mainWindow.clear()
mainWindow.setCursorPos(1, 1)
term.clear()
term.setCursorPos(1, 1)
