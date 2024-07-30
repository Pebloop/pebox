local File = require('src.models.file')

local ManageEvents = {}

local function isBox(boxX, boxY, boxWidth, boxHeight, mouseX, mouseY)
    return mouseX >= boxX and mouseX <= boxX + boxWidth and mouseY >= boxY and mouseY <= boxY + boxHeight
end

function ManageEvents.exec(event, window, data)
    local wx, wy = window.getSize()

    -- if keyboard
    if event[1] == 'key' then
        if event[2] == keys.leftCtrl then
            data.isLetMenuOpen = not data.isLetMenuOpen
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
    end
    
end

return ManageEvents