local ElementList = require("data.elements_list")

local WebloopManager = {}

local function dumpElement(element, depth)
    local indent = string.rep("  ", depth)
    local type = element.type
    local value = element.value

    if value then
        print(indent .. type .. " : " .. value)
    else
        print(indent .. type)
    end

    if element.children then
        print(indent .. "  children :")
        for i, child in ipairs(element.children) do
            dumpElement(child, depth + 1)
        end
    end
end

function WebloopManager.dumpAST(ast, depth)
    print("Webloop :")
    print("  body :")
    for i, element in ipairs(ast.children) do
        dumpElement(element, depth + 1)
    end
end

function WebloopManager.execute(head, body)
    -- TODO : implement head
    
    --WebloopManager.dumpAST(body, 1)
    term.clear()
    term.setCursorPos(1, 1)
    local data = {
        cursorX = 1,
        cursorY = 1,
    }
    while true do
        term.clear()
        ElementList[body.type](data, body.style, body.children)
    end

end

return WebloopManager