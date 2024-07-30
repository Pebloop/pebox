local Redraw = {}

function  Redraw.exec(window)
    window.clear()
    window.setCursorPos(1, 1)
    window.write('Hello, world!')
    window.redraw()
    
end

return Redraw