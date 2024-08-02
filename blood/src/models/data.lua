local Data = {
    isDirty = true,
    dirtyLines = {},
    isLetMenuOpen = false,
    exit = false,
    currentFile = nil,
    currentFolder = nil,
    codeWindow = nil,
    codeWrapperWindow = nil,
    codeCursor = {x = 1, y = 1},
    state = nil,
    stateData = {},
    snackbar = nil,
    snackbarTimer = 0,
    directory = nil,
    scroll = 0
}

function Data:new(window, wrapperWindow)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    -- setup data
    o.isDirty = true
    o.dirtyLines = {}
    o.isLetMenuOpen = false
    o.exit = false
    o.currentFile = nil
    o.currentFolder = nil
    o.codeWindow = window
    o.codeWrapperWindow = wrapperWindow
    o.codeCursor = {x = 1, y = 1}
    o.state = nil
    o.stateData = {}
    o.snackbar = nil
    o.snackbarTimer = 0
    o.directory = nil
    o.scroll = 0
    return o
end

return Data