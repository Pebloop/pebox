local SaveAsState = {}

function SaveAsState.events(event, window, data)
    local wx, wy = window.getSize()

    -- if keyboard
    if event[1] == 'char' then
        if data.stateData.path == "" then
            data.stateData.path = event[2]
        else
            data.stateData.path = data.stateData.path .. event[2]
        end
        data.isDirty = true
    end
end

return SaveAsState