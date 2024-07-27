local ElementList = require("data.elements_list")
local ElementSize = require("data.elements_size")
local Data = require("models.data")

local WebloopManager = {}

local scroll = 0

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

local function awaitChange(globalWindow, webWindow)
    local termWidth, termHeight = webWindow.getSize()
    local windowWidth, windowHeight = globalWindow.getSize()
    local event, data, x, y = os.pullEvent()

    if event == "mouse_scroll" then
        if scroll <= windowHeight - termHeight and data < 0 then
            scroll = scroll + 1
            globalWindow.reposition(1, scroll)
            globalWindow.redraw()
        elseif scroll >= 0 and data > 0 then
            scroll = scroll - 1
            globalWindow.reposition(1, scroll)
            globalWindow.redraw()
        end
        return false
    elseif event == "key" then
        if data == keys.up then
            if scroll <= windowHeight - termHeight then
                scroll = scroll + 1
                globalWindow.reposition(1, scroll)
                globalWindow.redraw()
            end
            return false
        elseif data == keys.down then
            if scroll >= 0 then
                scroll = scroll - 1
                globalWindow.reposition(1, scroll)
                globalWindow.redraw()
            end
            return false
        end
    elseif event == "mouse_click" then

    end
    return true
end

function WebloopManager.execute(head, body)
    return function(window)
        local webWindow = window
        WebloopManager.display(head, body, webWindow)
    end
end

function WebloopManager.display(head, body, webWindow)
    -- TODO : implement head

    local data = Data:new("webloop")
    local childData = data:child()
    childData.parent = data
    local pageSize = ElementSize[body.type](webWindow, childData, body.style, body.value)
    local screenSizeX, screenSizeY = webWindow.getSize()

    if screenSizeX > pageSize.width then
        pageSize.width = screenSizeX
    end

    if screenSizeY > pageSize.height then
        pageSize.height = screenSizeY
    end

    -- setup data
    local data = Data:new("webloop")
    local childData = data:child()
    childData.parent = data

    local globalWindow = window.create(webWindow, 1, 1, pageSize.width, pageSize.height)

    -- setup terminal
    globalWindow.setBackgroundColor(colors.black)
    globalWindow.setTextColor(colors.white)
    globalWindow.clear()
    globalWindow.setCursorPos(1, 1)

    -- execute body
    local data = ElementList[body.type](globalWindow, childData, body.style, body.value)
    webWindow.clear()
    print(textutils.serialize(data))
    os.pullEvent("key")

    while true do
        awaitChange(globalWindow, webWindow)
    end
end

return WebloopManager
