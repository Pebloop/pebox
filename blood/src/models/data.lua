local Data = {
    isDirty = true,
    isLetMenuOpen = false,
    exit = false
}

function Data:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    -- setup data
    o.isDirty = true
    o.isLetMenuOpen = false
    o.exit = false
    return o
end

return Data