local Utils = {}

function Utils.isBox(boxX, boxY, boxWidth, boxHeight, mouseX, mouseY)
    return mouseX >= boxX and mouseX <= boxX + boxWidth and mouseY >= boxY and mouseY <= boxY + boxHeight
end

function Utils.computeNewCursorPosition(data, x, y)
    if data.currentFile == nil then
        return 1, 1
    end
    local content = data.currentFile.content
    local lines = {}
    for line in string.gmatch(content, "[^\n]*\n?") do
        table.insert(lines, line)
    end
    local line = lines[y]
    if line == nil then
        return x, y
    end
    if x > string.len(line) + 1 and y < table.getn(lines) then
        x = 1
        y = y + 1
    elseif x < 1 and y > 1 then
        y = y - 1
        x = string.len(lines[y]) + 1
    elseif x < 1 and y == 1 then
        x = 1
    end

    -- if still out of bound
    if y < 1 then
        y = 1
    end
    if y > table.getn(lines) then
        y = table.getn(lines)
        x = string.len(lines[y]) + 1
    end
    if x < 1 then
        x = 1
    end
    if x > string.len(lines[y]) + 1 then
        x = string.len(lines[y]) + 1
    end

    -- scroll window to cursor
    local wx, wy = data.codeWrapperWindow.getSize()
    if y < data.scroll + 1 then
        data.scroll = y - 1
    elseif y > data.scroll + wy - 1 then
        data.scroll = y - wy + 1
    end

    return x, y
end

function Utils.computeContentPosition(data, x, y)
    if data.currentFile == nil then
        return 1
    end
    local content = data.currentFile.content
    local lines = {}
    for line in string.gmatch(content, "[^\n]*\n?") do
        table.insert(lines, line)
    end
    local position = 1
    data.codeWindow.clear()
    data.codeWindow.setCursorPos(1, 20)
    data.codeWindow.write('x: ' .. x .. ' y: ' .. y)
    data.codeWindow.setCursorPos(1, 21)
    data.codeWindow.write('scroll: ' .. data.scroll)
    os.pullEvent('key')
    for i = 1, y - 1 - data.scroll do
        if lines[i] ~= nil then
            position = position + string.len(lines[i])
        end
    end
    position = position + x - 1
    return position
end

return Utils