local BgBlack = {}

function BgBlack.exec(data, size)
    term.setBackgroundColor(colors.black)
    return data
end

return BgBlack