-- Imports --
local ConnectNameScreen = require("pebox.screens.connect_name_screen")

-- Peripherals --
local modem = peripheral.find("modem")

-- Local variables --
-- The id of the computer
local id = os.getComputerID()

if not modem then
    print("No modem attached, exiting")
    return
end

modem.open(6)

ConnectNameScreen.display()
local name = io.read()