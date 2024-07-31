local Redraw = require('src.redraw')
local Data = require('src.models.data')
local ManageEvents = require('src.manage_events')
local Colors = require('src.data.colors')

term.setPaletteColor(Colors.background, 0x292929) -- background color
term.setPaletteColor(Colors.text, 0xFFFFFF) -- basic text color
term.setPaletteColor(Colors.firstElevation, 0x4f4f4f) -- 1st elevation color
term.setPaletteColor(Colors.text2, 0xff7d7d) -- 2nd text color
term.setPaletteColor(Colors.text3, 0x68ad65) -- 3rd text color
term.setPaletteColor(Colors.text4, 0x8a7557) -- 4th text color
term.setPaletteColor(Colors.text5, 0x3b8ab8) -- 5th text color
term.setPaletteColor(Colors.text6, 0xf59562) -- 6th text color

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
mainWindow.setPaletteColor(colors.yellow, 0xDEDE6C)
mainWindow.setPaletteColor(colors.lime, 0x7FCC19)
mainWindow.setPaletteColor(colors.pink, 0xF2B2CC)
mainWindow.setPaletteColor(colors.gray, 0x4C4C4C)
mainWindow.setPaletteColor(colors.lightGray, 0x999999)
mainWindow.setPaletteColor(colors.cyan, 0x4C99B2)
mainWindow.setPaletteColor(colors.purple, 0xB266E5)
mainWindow.setPaletteColor(colors.blue, 0x3366CC)
mainWindow.setPaletteColor(colors.brown, 0x7F664C)
mainWindow.setPaletteColor(colors.green, 0x57A64E)
mainWindow.setPaletteColor(colors.red, 0xCC4C4C)
mainWindow.setPaletteColor(colors.black, 0x111111)

mainWindow.setBackgroundColor(colors.black)
mainWindow.setTextColor(colors.white)
mainWindow.clear()
mainWindow.setCursorPos(1, 1)
term.clear()
term.setCursorPos(1, 1)
