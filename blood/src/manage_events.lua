local File = require('src.models.file')
local MainState = require('src.states.main_state')

local ManageEvents = {}

function ManageEvents.exec(event, window, data)
    if data.popup == nil then
        MainState.events(event, window, data)
    else
        
    end
    
end

return ManageEvents