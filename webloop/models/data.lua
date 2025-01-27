local Data = {
    type = "unkown",
    x = 1,
    y = 1,
    width = 0,
    height = 0,
    parent = nil,
    bg_color = colors.black,
    text_color = colors.white,
    text_align = "start",
    id = nil
}

function Data:new(type, width, height)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    -- setup data
    o.type = type or "unknown"
    o.x = 1
    o.y = 1
    o.width = width or -1
    o.height = height or -1
    o.parent = nil
    o.bg_color = colors.black
    o.text_color = colors.white
    o.text_align = "start"

    return o
end

function Data:copy(data)
    local copy = Data:new()
    copy.type = data.type
    copy.x = data.x
    copy.y = data.y
    copy.width = data.width
    copy.height = data.height
    copy.parent = data.parent
    copy.bg_color = data.bg_color
    copy.text_color = data.text_color
    copy.text_align = data.text_align
    copy.id = data.id
    return copy
end

function Data:dump()
    print("Data :")
    print("  x : " .. self.x)
    print("  y : " .. self.y)
    print("  width : " .. self.width)
    print("  height : " .. self.height)
    print("  bg_color : " .. self.bg_color)
    print("  text_color : " .. self.text_color)
    print("  text_align : " .. self.text_align)
    print("  id : " .. self.id)
end

function Data:child(childPosition, width, height)
    local child = Data:new()
    child.parent = self
    child.x = childPosition and childPosition.x or 1
    child.y = childPosition and childPosition.y or 1
    child.height = height or -1
    child.width = width or -1
    child.bg_color = self.bg_color
    child.text_color = self.text_color
    child.text_align = self.text_align
    return child
end

function Data:parentalSize(window)
    local w = -1
    local h = -1
    local parentData = self

    while parentData do
        if w == -1 then
            w = parentData.width
        end
        if h == -1 then
            h = parentData.height
        end
        parentData = parentData.parent
    end

    if w == -1 then
        w = window.getSize()
    end

    if h == -1 then
        _, h = window.getSize()
    end

    return w, h
end

return Data