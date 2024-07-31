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
    end

    -- if still out of bound
    if y < 1 then
        y = 1
    end
    if y > table.getn(lines) then
        y = table.getn(lines)
    end
    if x < 1 then
        x = 1
    end
    if x > string.len(lines[y]) + 1 then
        x = string.len(lines[y]) + 1
    end

    return x, y
end

function Utils.computeContentPosition(data, x, y)
    if data.currentFile == nil then
        return 1
    end
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

return Utils