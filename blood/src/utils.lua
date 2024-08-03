local Utils = {}

function Utils.isBox(boxX, boxY, boxWidth, boxHeight, mouseX, mouseY)
    return mouseX >= boxX and mouseX <= boxX + boxWidth and mouseY >= boxY and mouseY <= boxY + boxHeight
end

function Utils.computeNewCursorPosition(data, x, y)
    if data.currentFile == nil then
        return 1, 1
    end
    local content = data.currentFile.content
    local wx, wy  = data.codeWrapperWindow.getSize()
    local lines = {}
    for line in string.gmatch(content, "[^\n]*\n?") do
        table.insert(lines, line)
    end
    local line = lines[y]

    if x <= 1 then
        if y > 1 then
            y = y - 1
            line = lines[y]
            x = string.len(line) + 1
        else
            x = 1
        end
    end

    if x > string.len(line) + 1 then
        if y < #lines then
            y = y + 1
            x = 1
        else
            x = string.len(line) + 1
        end
    end
   
    if y <= 1 then
        data.scroll = data.scroll + 1
        y = 1
    end
    if y >= wy then
        data.scroll = data.scroll - 1
        y = wy - 1
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
    for i = 1, y - 1 - data.scroll do
        if lines[i] ~= nil then
            position = position + string.len(lines[i])
        end
    end
    position = position + x - 1
    return position
end

return Utils