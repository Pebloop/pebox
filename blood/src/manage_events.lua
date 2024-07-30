local File = require('src.models.file')
local CodeState = require('src.states.code_state')
local SaveAsState = require('src.states.save_as_state')

local ManageEvents = {}

function ManageEvents.exec(event, window, data)
    term.clear()
    term.setCursorPos(1, 1)
    print(CodeState)
    if data.popup == nil then
        CodeState.events(event, window, data)
    elseif data.popup == "save-as" then
        SaveAsState.events(event, window, data)
    end
end

return ManageEvents