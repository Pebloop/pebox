local Redraw = {}

local function drawLeftMenu(window)
    local wx, wy = window.getSize()
    window.setBackgroundColor(3)
    window.setTextColor(2)
    for i = 1, wy do
        window.setCursorPos(1, i)
        window.write('                   ')
    end
    window.setCursorPos(1, 1)

    window.setBackgroundColor(1)
end

local function drawHeader(window)
    local wx, wy = window.getSize()
    window.setBackgroundColor(3)
    window.setTextColor(2)
    for i = 1, wx do
        window.setCursorPos(i, 1)
        window.write('O')
    end
    window.setCursorPos(1, 1)
    window.write('Blood')
    window.setCursorPos(wx - 1, 1)
    window.write('X')
    window.setBackgroundColor(1)
end

function  Redraw.exec(window, data)
    window.setBackgroundColor(1)
    window.setTextColor(2)
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