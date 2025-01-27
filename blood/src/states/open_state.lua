local File = require('src.models.file')

local OpenAsState = {}

function OpenAsState.events(event, window, data)
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
                -- check if it is a file or a directory
                if fs.isDir(data.stateData.path) then
                    data.state = nil
                    data.directory = data.stateData.path
                else
                    local file = fs.open(data.stateData.path, 'r')

                    if file == nil then
                        data.snackbar = "File not found"
                        data.snackbarTimer = 3
                        data.stateData.path = ""
                        data.isDirty = true
                        return
                    end

                    -- get filename from path
                    local filename = data.stateData.path:match("^.+/(.+)$")
                    data.currentFile = File:new(filename, data.stateData.path, file.readAll())
                    file.close()
                    data.state = nil
                    data.isDirty = true
                    data.dirtyLines = {-1}
                end
            end
        elseif event[2] == keys.backspace then
            data.stateData.path = data.stateData.path:sub(1, #data.stateData.path - 1)
            data.isDirty = true
        end
    end
end

return OpenAsState