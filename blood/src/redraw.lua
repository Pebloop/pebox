local Redraw = {}

local function drawLeftMenu(window)
    window.setBackgroundColor(3)
    window.setTextColor(2)
    wx, wy = window.getSize()
    for i = 1, wy do
        window.setCursorPos(1, i)
        window.write('                   ')
    end
    window.setCursorPos(1, 1)

    window.setBackgroundColor(1)
end

local function drawHeader(window)
    window.setBackgroundColor(3)
    window.setTextColor(2)
    wx, wy = window.getSize()
    for i = 1, wx do
        window.setCursorPos(i, 1)
        window.write(' ')
    end
    window.setCursorPos(1, 1)
    window.write('Blood')
    window.setBackgroundColor(1)
end

function  Redraw.exec(window, data)
    window.clear()
    window.setCursorPos(1, 1)
    window.write('Hello, world!')
    window.redraw()
    
    if data.isLetMenuOpen then
        drawLeftMenu(window)
    end
    drawHeader(window)
end

return Redraw