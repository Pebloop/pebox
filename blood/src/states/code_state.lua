local File = require('src.models.file')
local CodeState = {}
local Utils = require('src.utils')

function CodeState.events(event, window, data)
    local wx, wy = window.getSize()
    local lines = {}
    if data.currentFile then
        for line in string.gmatch(data.currentFile.content, "[^\n]*\n?") do
            table.insert(lines, line)
        end
    end

    -- if keyboard
    if event[1] == 'key' then
        if event[2] == keys.leftCtrl then
            if data.directory then
                data.isLetMenuOpen = not data.isLetMenuOpen
                data.isDirty = true
            end
        elseif event[2] == keys.left then
            data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, data.codeCursor.x - 1, data.codeCursor.y, "left")
        elseif event[2] == keys.right then
            data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, data.codeCursor.x + 1, data.codeCursor.y, "right")
        elseif event[2] == keys.up then
            data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, data.codeCursor.x, data.codeCursor.y - 1, "up")
            data.isDirty = true
        elseif event[2] == keys.down then
            data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, data.codeCursor.x, data.codeCursor.y + 1, "down")
            data.isDirty = true
        elseif event[2] == keys.enter then
            local position = Utils.computeContentPosition(data, data.codeCursor.x, data.codeCursor.y)
            data.currentFile.content = string.sub(data.currentFile.content, 1, position - 1) .. '\n' .. string.sub(data.currentFile.content, position)
            data.codeCursor.x = 1
            local wx, wy = data.codeWrapperWindow.getSize()
            local lines = {}
            for line in string.gmatch(data.currentFile.content, "[^\n]*\n?") do
                table.insert(lines, line)
            end
            for i = data.codeCursor.y - 1, #lines do
                data.dirtyLines[#data.dirtyLines + 1] = i
            end
            data.codeWindow.reposition(1, data.scroll + 1, wx, #lines + 1)
            data.codeCursor.y = data.codeCursor.y + 1
            data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, data.codeCursor.x, data.codeCursor.y, "down")
            data.isDirty = true

        elseif event[2] == keys.backspace then
            if data.codeCursor.x == 1 and data.codeCursor.y == 1 then
                return
            end
            local position = Utils.computeContentPosition(data, data.codeCursor.x, data.codeCursor.y)
            local newCursorX = 0
            if data.codeCursor.y > 1 then
                newCursorX = string.len(lines[data.codeCursor.y - 1]) + 1
            end
            data.currentFile.content = string.sub(data.currentFile.content, 1, position - 2) .. string.sub(data.currentFile.content, position)
            if data.codeCursor.x > 1 then
                data.dirtyLines = {data.codeCursor.y}
                data.codeCursor.x = data.codeCursor.x - 1
            else
                local wx, wy = data.codeWrapperWindow.getSize()
                local lines = {}
                for line in string.gmatch(data.currentFile.content, "[^\n]*\n?") do
                    table.insert(lines, line)
                end
                for i = data.codeCursor.y - 1, #lines do
                    data.dirtyLines[#data.dirtyLines + 1] = i
                end
                data.codeWindow.reposition(1, data.scroll + 1, wx, #lines + 1)
                data.codeCursor.x = newCursorX
                data.codeCursor.y = data.codeCursor.y - 1
            end
            data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, data.codeCursor.x, data.codeCursor.y, "left")
            data.isDirty = true
        end

    -- if mouse click
    elseif event[1] == 'mouse_click' then

        if event[3] == wx and event[4] == 1 then
            data.exit = true
        elseif Utils.isBox(1, 1, 4, 1, event[3], event[4]) then
            if data.directory then
                data.isLetMenuOpen = not data.isLetMenuOpen
                data.isDirty = true
            end
        elseif Utils.isBox(7, 1, 3, 1, event[3], event[4]) then
            data.currentFile = File:new("new_file")
            data.codeCursor.x = 1
            data.codeCursor.y = 1
            data.isDirty = true
        elseif Utils.isBox(12, 1, 4, 1, event[3], event[4]) then
            data.state = "open"
            data.stateData = {path = ""}
            data.isDirty = true
        elseif Utils.isBox(17, 1, 4, 1, event[3], event[4]) then
            if data.currentFile ~= nil then
                if data.currentFile.path then
                    data.currentFile:save()
                else
                    data.state = "save-as"
                    data.stateData = {path = ""}
                    data.isDirty = true
                end
            end
        else
            if data.isLetMenuOpen then
                if Utils.isBox(15, 2, wx - 15, wy - 1, event[3], event[4]) then
                    data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, event[3] - 15, event[4] + data.scroll - 1, "right")
                end
            elseif Utils.isBox(1, 2, wx, wy - 1, event[3], event[4]) then
                data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, event[3], event[4] + data.scroll - 1, "right")
            end
        end

    elseif event[1] == 'char' then
        if data.currentFile == nil then
            data.currentFile = File:new("new_file")
        end
        local newChar = event[2]
        local position = Utils.computeContentPosition(data, data.codeCursor.x, data.codeCursor.y)
        data.currentFile.content = string.sub(data.currentFile.content, 1, position - 1) .. newChar .. string.sub(data.currentFile.content, position)
        data.codeCursor.x = data.codeCursor.x + 1
        if event[2] == '\n' then
            data.codeCursor.x = 1
            data.codeCursor.y = data.codeCursor.y + 1
        end
        data.dirtyLines = {data.codeCursor.y}
        data.isDirty = true
    elseif event[1] == 'mouse_scroll' then
        data.scroll = data.scroll - event[2]
        if data.scroll > 0 then
            data.scroll = 0
        end
        if data.scroll < - #lines + wy - 1 then
            data.scroll = - #lines + wy - 1
        end
        data.codeCursor.x, data.codeCursor.y = Utils.computeNewCursorPosition(data, data.codeCursor.x, data.codeCursor.y, "right")
        data.isDirty = true
    end
end

return CodeState