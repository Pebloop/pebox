local ElementList = require("data.elements_list")
local ElementSize = require("data.elements_size")
local ElementClick = require("data.elements_click")
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

local function clicked(x, y, data)
    if type(data) == "table" and data.type == nil then
        for i, child in ipairs(data) do
            local result = clicked(x, y, child)
            if result then
                return result
            end
        end
    else
        if x >= data.x and x <= data.x + data.width and y >= data.y and y <= data.y + data.height then
            return data
        end
        return nil
    end
    return nil
end


local function awaitChange(globalWindow, webWindow, datas)
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
        return nil
    elseif event == "key" then
        if data == keys.up then
            if scroll <= windowHeight - termHeight then
                scroll = scroll + 1
                globalWindow.reposition(1, scroll)
                globalWindow.redraw()
            end
            return nil
        elseif data == keys.down then
            if scroll >= 0 then
                scroll = scroll - 1
                globalWindow.reposition(1, scroll)
                globalWindow.redraw()
            end
            return nil
        end
    elseif event == "mouse_click" then
        local obj = clicked(x, y, datas)
        if obj then
            return ElementClick[obj.type](globalWindow, obj)
        end

    end
    return nil
end

function WebloopManager.execute(head, body)
    return function(window)
        local webWindow = window
        return WebloopManager.display(head, body, webWindow)
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
    childData.id = body.id
    childData.link = body.link

    local globalWindow = window.create(webWindow, 1, 1, pageSize.width, pageSize.height)

    -- setup terminal
    globalWindow.setBackgroundColor(colors.black)
    globalWindow.setTextColor(colors.white)
    globalWindow.clear()
    globalWindow.setCursorPos(1, 1)

    -- execute body
    local datas = ElementList[body.type](globalWindow, childData, body.style, body.value)

    local response = {}
    while true do
        local exit = awaitChange(globalWindow, webWindow, datas)
        if exit then
            response.url = exit.url
            break
        end
    end

    return response
end

return WebloopManager
