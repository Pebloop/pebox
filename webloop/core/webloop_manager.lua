local ElementList = require("data.elements_list")
local Data = require("models.data")

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

local function awaitChange()
    if os.pullEvent() == "key" then
        return false
    end
    return true
end

function WebloopManager.execute(head, body)
    -- TODO : implement head
    
    --WebloopManager.dumpAST(body, 1)
    while true do
        -- setup terminal
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
        term.clear()
        term.setCursorPos(1, 1)

        -- setup data
        local data = Data:new("webloop")
        local childData = data:child()
        childData.parent = data
        
        -- execute body
        ElementList[body.type](childData, body.style, body.children)

        -- events
        local change = true
        while change do
            change = awaitChange()
        end
    end

end

return WebloopManager