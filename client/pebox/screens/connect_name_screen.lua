local ConnectNameScreen = {}

function ConnectNameScreen.display()
    term.clear()
    local width, height = term.getSize()
    term.setCursorPos(width / 2 - 2, 3)
    term.write("PEBOX")
    term.setCursorPos(width / 2 - 10, 5)
    term.write("Enter your name: ")
    term.setCursorPos(width / 2 - 10, 7)
end

return ConnectNameScreen