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

function File:save()
    if self.path then
        local file = fs.open(self.path, 'w')
        file.write(self.content)
        file.close()
    end
end

return File