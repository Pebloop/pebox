local ManageEvents = {}

function ManageEvents.exec(event, window, data)
    if event[1] == 'key' then
        if event[2] == keys.leftCtrl then
            data.isLetMenuOpen = not data.isLetMenuOpen
            data.isDirty = true
        end
    end
    
end

return ManageEvents