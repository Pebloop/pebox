local File = {
    name = nil,
    path = nil,
    content = nil
}

function File:new(name, path, content)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    -- setup file
    o.name = name or "new_file"
    o.path = path or nil
    o.content = content or ""
    return o
end