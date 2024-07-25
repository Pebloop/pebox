local Data = {
    type = "unkown",
    x = 1,
    y = 1,
    width = 0,
    height = 0,
    parent = nil,
    bg_color = colors.black,
    text_color = colors.white,
    text_align = "begin"
}

function Data:new(o, type, width, height)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    -- setup data
    o.type = type or "unkown"
    o.x = 1
    o.y = 1
    o.width = width or 0
    o.height = height or 0
    o.parent = nil
    o.bg_color = colors.black
    o.text_color = colors.white
    o.text_align = "begin"

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
end

function Data:child(childPosition, width, height)
    local child = Data:new()
    child.parent = self
    child.x = childPosition.x
    child.y = childPosition.y
    child.height = height or 0
    child.width = width or 0
    return child
end

return Data