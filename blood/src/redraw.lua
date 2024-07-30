local Colors = require('data.colors')

local Redraw = {}

local function drawLeftMenu(window)
    local wx, wy = window.getSize()
    window.setBackgroundColor(Colors.firstElevation)
    window.setTextColor(Colors.text)
    for i = 1, wy do
        window.setCursorPos(1, i)
        window.write('                   ')
    end
    window.setCursorPos(1, 1)

    window.setBackgroundColor(Colors.background)
end

local function drawHeader(window)
    local wx, wy = window.getSize()
    window.setBackgroundColor(Colors.firstElevation)
    window.setTextColor(Colors.text)
    for i = 1, wx do
        window.setCursorPos(i, 1)
        window.write('O')
    end
    window.setCursorPos(1, 1)
    window.write('Blood')
    window.setCursorPos(wx - 1, 1)
    window.write('X')
    window.setBackgroundColor(Colors.background)
end

function  Redraw.exec(window, data)
    window.setBackgroundColor(Colors.background)
    window.setTextColor(Colors.text)
    window.clear()
    window.setCursorPos(20, 20)
    window.write('Hello, world!')
    
    if data.isLetMenuOpen then
        drawLeftMenu(window)
    end
    drawHeader(window)

    window.redraw()
end

return Redraw