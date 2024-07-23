local WebloopManager = {}

function WebloopManager.dumpAST(ast)
    for i, element in ipairs(ast) do
        print("Element " .. i)
        print("Type: " .. element.type)
        print("Style: " .. element.style)
        print("Value: " .. element.value)
        print("Children: ")
        WebloopManager.dumpAST(element.children)
    end
end

function WebloopManager.execute(head, body)
    -- TODO : implement head
    
    local bodyElements = body

    WebloopManager.dumpAST(bodyElements)
end

return WebloopManager