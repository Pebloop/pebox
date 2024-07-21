-- player object

local Player = {id = -1, name = ""}

function Player:new(o, id, name)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.id = id or -1
    self.name = name or ""
    return o
end