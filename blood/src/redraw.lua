local Colors = require('src.data.colors')

local Redraw = {}

local function drawLeftMenu(window)
    local wx, wy = window.getSize()
    window.setBackgroundColor(Colors.firstElevation)
    window.setTextColor(Colors.text)
    for i = 1, wy do
        window.setCursorPos(1, i)
        window.write('              ')
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
        window.write(' ')
    end
    window.setCursorPos(1, 1)
    window.write('Blood')
    window.setCursorPos(7, 1)
    window.write('New')
    window.setCursorPos(11, 1)
    window.write('Open')
    window.setCursorPos(16, 1)
    window.write('Save')
    window.setCursorPos(wx, 1)
    window.write('X')
    window.setBackgroundColor(Colors.background)
end

local function drawSaveAsPopup(mainWindow)
    local wx, wy = mainWindow.getSize()
    local popupWindow = window.create(mainWindow, wx / 2 - 10, wy / 2 - 5, 20, 10)
    popupWindow.setBackgroundColor(Colors.firstElevation)
    popupWindow.setTextColor(Colors.text)
    popupWindow.clear()
    popupWindow.setCursorPos(1, 1)
    popupWindow.write('Save as')
    popupWindow.setCursorPos(1, 2)
    popupWindow.write('path:')
    popupWindow.setCursorPos(1, 4)
    popupWindow.write('Cancel')
    popupWindow.setCursorPos(1, 5)
    popupWindow.write('Save')
end

local function drawCode(data)
    if data.currentFile == nil then
        return
    end
    local wx, wy = data.codeWindow.getSize()
    data.codeWindow.setBackgroundColor(Colors.background)
    data.codeWindow.setTextColor(Colors.text)
    data.codeWindow.clear()
    data.codeWindow.setCursorPos(1, 1)

    -- split content in lines
    local lines = {}
    for line in string.gmatch(data.currentFile.content, "[^\n]+") do
        table.insert(lines, line)
    end

    -- draw lines
    for i = 1, wy do
        if lines[i] == nil then
            break
        end
        data.codeWindow.setCursorPos(1, i)
        data.codeWindow.write(lines[i])
    end
end

function  Redraw.exec(window, data)
    window.setBackgroundColor(Colors.background)
    window.setTextColor(Colors.text)
    window.clear()
    data.codeWindow.redraw()
    
    if data.isLetMenuOpen then
        data.codeWindow.reposition(15, 2, window.getSize() - 15, window.getSize() - 1)
        data.codeWindow.redraw()
        drawLeftMenu(window)
    else
        data.codeWindow.reposition(1, 2, window.getSize(), window.getSize() - 1)
        data.codeWindow.redraw()
    end
    drawHeader(window)
    drawCode(data)
    window.redraw()

    -- popups
    if data.popup ~= nil then
        if data.popup == 'save-as' then
            drawSaveAsPopup(window)
        end
    end

    data.isDirty = false
end

return Redraw