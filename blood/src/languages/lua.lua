local pretty = require "cc.pretty"

local LuaLang = {}

function LuaLang.pretty(code)
    local doc = pretty.empty

    for line in string.gmatch(code, "[^\n]+") do
        for token in string.gmatch(line, "%S+") do
            doc = pretty.concat(doc, pretty.text(token, colours.blue), pretty.space)
        end
        doc = pretty.concat(doc, pretty.line)
    end
    return pretty.render(doc)
end

return LuaLang