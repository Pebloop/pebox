local Data = {
    isDirty = true,
    isLetMenuOpen = false,
    exit = false,
    currentFile = nil,
    codeWindow = nil
}

function Data:new(window)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    -- setup data
    o.isDirty = true
    o.isLetMenuOpen = false
    o.exit = false
    o.currentFile = nil
    o.codeWindow = window
    return o
end

return Data