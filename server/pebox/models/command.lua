-- command object
local PeboxCore = require("pebox/pebox_core")

local Command = {id = -1, command = "", args = {}}

function Command:new(o, event)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.id = PeboxCore.id(event) or -1
    self.command =  PeboxCore.command(event) or ""
    self.args = PeboxCore.args(event) or {}
    return o
end