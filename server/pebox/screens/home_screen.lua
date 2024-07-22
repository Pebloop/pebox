local HomeScreen = {}

function HomeScreen.draw(playerList, code)
    local monitor = peripheral.find("monitor")
    local monitorW, monitorH = monitor.getSize()
    monitor.clear()
    monitor.setCursorPos(monitorW / 2 - 2, monitorH / 2 - 3)
    monitor.write("Pebox" )
    monitor.setCursorPos(monitorW / 2 - 2,monitorH / 2)
    monitor.write(code)
    for i = 1, 8 do
        monitor.setCursorPos(1, monitorH - 8 + i)
        monitor.write(i .. ":")
    end
    for i = 1, #playerList do
        monitor.setCursorPos(3, monitorH - 8 + i)
        monitor.write(playerList[i].name)
    end
end

return HomeScreen