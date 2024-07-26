local Minifont = {}

function Minifont.draw(char)
    local charsList = require("minifont.char_list")
    for i=1, #char do
        term.write(charsList[char[i]])
    end
end

return Minifont