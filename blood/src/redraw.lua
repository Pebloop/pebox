local Redraw = {}

local function drawLeftMenu(window)
    window.setBackgroundColor(3)
    wx, wy = window.getSize()
    for i = 1, wy do
        window.setCursorPos(1, i)
        window.write('                   ')
    end
end

function  Redraw.exec(window, data)
    window.clear()
    window.setCursorPos(1, 1)
    window.write('Hello, world!')
    window.redraw()
    
    if data.isLetMenuOpen then
        drawLeftMenu(window)
    end
end

return Redraw