local Colors = require('src.data.colors')
local LuaLang = require('src.languages.lua')
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

local function drawSaveAsPopup(mainWindow, data)
    local wx, wy = mainWindow.getSize()
    local popupWindow = window.create(mainWindow, wx / 2 - 10, wy / 2 - 4, 20, 8)
    popupWindow.setBackgroundColor(Colors.firstElevation)
    popupWindow.setTextColor(Colors.text)
    popupWindow.clear()
    popupWindow.setCursorPos(7, 2)
    popupWindow.write('Save as')
    popupWindow.setCursorPos(3, 4)
    popupWindow.write('path: ')
    popupWindow.write(data.stateData.path)
    popupWindow.setCursorPos(3, 7)
    popupWindow.write('Save')
    popupWindow.setCursorPos(12, 7)
    popupWindow.write('Cancel')
end

local function drawOpenPopup(mainWindow, data)
    local wx, wy = mainWindow.getSize()
    local popupWindow = window.create(mainWindow, wx / 2 - 15, wy / 2 - 4, 30, 8)
    popupWindow.setBackgroundColor(Colors.firstElevation)
    popupWindow.setTextColor(Colors.text)
    popupWindow.clear()
    popupWindow.setCursorPos(9, 2)
    popupWindow.write('Open')
    popupWindow.setCursorPos(3, 4)
    popupWindow.write('path: ')
    popupWindow.write(data.stateData.path)
    popupWindow.setCursorPos(3, 7)
    popupWindow.write('Open')
    popupWindow.setCursorPos(12, 7)
    popupWindow.write('Cancel')
    
end

local function drawCode(data)
    if data.currentFile == nil then
        return
    end
    local wx, wy = data.codeWindow.getSize()
    data.codeWindow.setBackgroundColor(Colors.background)
    data.codeWindow.setTextColor(Colors.text)
    data.codeWindow.setCursorPos(1, 1)

    local code = data.currentFile.content
    LuaLang.pretty(code, data.codeWindow, data)
end

function  Redraw.exec(window, data)
    window.setBackgroundColor(Colors.background)
    window.setTextColor(Colors.text)
    window.setCursorBlink(false)

    local lines = {}
    if data.currentFile ~= nil then
        for line in string.gmatch(data.currentFile.content, "[^\n]*\n?") do
            table.insert(lines, line)
        end
    end
    
    if data.isLetMenuOpen then
        data.codeWindow.reposition(15, data.scroll + 1, window.getSize() - 15, #lines + 1)
        drawLeftMenu(window)
    else
        data.codeWindow.reposition(1, data.scroll + 1, window.getSize(), #lines + 1)
    end
    drawHeader(window)
    drawCode(data)

    -- popups
    if data.state ~= nil then
        if data.state == 'save-as' then
            drawSaveAsPopup(window, data)
        elseif data.state == 'open' then
            drawOpenPopup(window, data)
        end
    end

    -- snackbar
    if data.snackbar ~= nil then
        window.setBackgroundColor(Colors.firstElevation)
        window.setTextColor(Colors.text)
        window.setCursorPos(1, window.getSize())
        window.write(data.snackbar)
        window.setBackgroundColor(Colors.background)
        data.snackbarTimer = data.snackbarTimer - 1

        if data.snackbarTimer <= 0 then
            data.snackbar = nil
        end
    end

    window.setCursorBlink(true)
    data.isDirty = false
end

return Redraw