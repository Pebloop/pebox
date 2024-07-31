local pretty = require "cc.pretty"

local LuaLang = {}

function LuaLang.pretty(code)
    local doc = pretty.empty()

    return pretty.render(doc)
end

return LuaLang