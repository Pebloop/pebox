local ElementList = require("data.elements_list")
local ElementSize = require("data.elements_size")
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

local function awaitChange(globalWindow)
    if os.pullEvent() == "scroll" then
        globalWindow.scroll(1)
        return false
    end
    return true
end

function WebloopManager.execute(head, body)
    -- TODO : implement head

    local data = Data:new("webloop")
    local childData = data:child()
    childData.parent = data
    local pageSize = ElementSize[body.type](childData, body.style, body.children)

    -- setup data
    local data = Data:new("webloop")
    local childData = data:child()
    childData.parent = data
    
    local globalWindow = window.create(term.current(), 1, 1, pageSize)

    -- setup terminal
    globalWindow.setBackgroundColor(colors.black)
    globalWindow.setTextColor(colors.white)
    globalWindow.clear()
    globalWindow.setCursorPos(1, 1)

    -- execute body
    ElementList[body.type](globalWindow, childData, body.style, body.children)

    while true do
        -- events
        local change = true
        while change do
            change = awaitChange(globalWindow)
        end
    end

end

return WebloopManager