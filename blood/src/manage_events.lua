local File = require('src.models.file')

local ManageEvents = {}

local function isBox(boxX, boxY, boxWidth, boxHeight, mouseX, mouseY)
    return mouseX >= boxX and mouseX <= boxX + boxWidth and mouseY >= boxY and mouseY <= boxY + boxHeight
end

local function computeNewCursorPosition(data, x, y)
    local content = data.currentFile.content
    local lines = {}
    for line in string.gmatch(content, "[^\n]+") do
        table.insert(lines, line)
    end
    local line = lines[y]
    if line == nil then
        return x, y
    end
    if x > string.len(line) and y < table.getn(lines) then
        x = 1
        y = y + 1
    elseif x < 1 and y > 1 then
        y = y - 1
        x = string.len(lines[y]) + 1
    elseif x < 1 then
        x = 1
    elseif x > string.len(line) + 1 then
        x = string.len(line) + 1
    end
    if y < 1 then
        y = 1
    end
    if y > table.getn(lines) then
        y = table.getn(lines)
    end

    return x, y
end

local function computeContentPosition(data, x, y)
    local content = data.currentFile.content
    local lines = {}
    for line in string.gmatch(content, "[^\n]+") do
        table.insert(lines, line)
    end
    local position = 1
    for i = 1, y - 1 do
        position = position + string.len(lines[i]) + 1
    end
    position = position + x - 1
    return position
end

function ManageEvents.exec(event, window, data)
    local wx, wy = window.getSize()

    -- if keyboard
    if event[1] == 'key' then
        if event[2] == keys.leftCtrl then
            data.isLetMenuOpen = not data.isLetMenuOpen
            data.isDirty = true
        elseif event[2] == keys.left then
            data.codeCursor.x, data.codeCursor.y = computeNewCursorPosition(data, data.codeCursor.x - 1, data.codeCursor.y)
        elseif event[2] == keys.right then
            data.codeCursor.x, data.codeCursor.y = computeNewCursorPosition(data, data.codeCursor.x + 1, data.codeCursor.y)
        elseif event[2] == keys.up then
            data.codeCursor.x, data.codeCursor.y = computeNewCursorPosition(data, data.codeCursor.x, data.codeCursor.y - 1)
        elseif event[2] == keys.down then
            data.codeCursor.x, data.codeCursor.y = computeNewCursorPosition(data, data.codeCursor.x, data.codeCursor.y + 1)
        elseif event[2] == keys.enter then
            local position = computeContentPosition(data, data.codeCursor.x, data.codeCursor.y)
            data.currentFile.content = string.sub(data.currentFile.content, 1, position - 1) .. '\n' .. string.sub(data.currentFile.content, position)
            data.codeCursor.x = 1
            data.codeCursor.y = data.codeCursor.y + 1
            data.isDirty = true
        elseif event[2] == keys.backspace then
            local position = computeContentPosition(data, data.codeCursor.x, data.codeCursor.y)
            data.currentFile.content = string.sub(data.currentFile.content, 1, position - 2) .. string.sub(data.currentFile.content, position)
            data.codeCursor.x, data.codeCursor.y = computeNewCursorPosition(data, data.codeCursor.x - 1, data.codeCursor.y)
            data.isDirty = true
        end

    -- if mouse click
    elseif event[1] == 'mouse_click' then

        if event[3] == wx and event[4] == 1 then
            data.exit = true
        elseif isBox(1, 1, 4, 1, event[3], event[4]) then
            data.isLetMenuOpen = not data.isLetMenuOpen
            data.isDirty = true
        elseif isBox(7, 1, 3, 1, event[3], event[4]) then
            data.currentFile = File:new("new_file")
            data.isDirty = true
        elseif isBox(12, 1, 4, 1, event[3], event[4]) then
        end

    elseif event[1] == 'char' then
        if data.currentFile == nil then
            data.currentFile = File:new("new_file")
        end
        local newChar = event[2]
        local position = data.codeCursor.x
        for i, line in string.gmatch(data.currentFile.content, "[^\n]+") do
            if data.codeCursor.y == i then
                position = position + string.len(line)
                break
            end
        end
        data.currentFile.content = string.sub(data.currentFile.content, 1, position - 1) .. newChar .. string.sub(data.currentFile.content, position)
        data.codeCursor.x = data.codeCursor.x + 1
        if event[2] == '\n' then
            data.codeCursor.x = 1
            data.codeCursor.y = data.codeCursor.y + 1
        end
        data.isDirty = true
    end
    
end

return ManageEvents