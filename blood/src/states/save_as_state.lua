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
                local file = fs.open(data.stateData.path, 'w')
                file.write(data.currentFile.content)
                file.close()
                data.state = nil
                data.isDirty = true
            end
        elseif event[2] == keys.backspace then
            data.stateData.path = data.stateData.path:sub(1, #data.stateData.path - 1)
            data.isDirty = true
        end
    end
end

return SaveAsState