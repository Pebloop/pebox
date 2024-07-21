-- command object
local Core = require("pebox.server_core")

local Command = {id = -1, command = "", args = {}}

function Command:new(o, event)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.id = Core.id(event) or -1
    self.command =  Core.command(event) or ""
    self.args = Core.args(event) or {}
    return o
end