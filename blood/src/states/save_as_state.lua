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
    elseif event[1] == 'key' then
        if event[2] == keys.enter then
            if data.stateData.path ~= "" then
                data.currentFile = fs.open(data.stateData.path, 'w')
                data.currentFile.write(data.currentFile.content)
                data.currentFile.close()
                data.state = nil
            end
        elseif event[2] == keys.backspace then
            data.stateData.path = data.stateData.path:sub(1, #data.stateData.path - 1)
            data.isDirty = true
        end
    end
end

return SaveAsState