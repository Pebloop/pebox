local BgMAgenta = {}

function BgMAgenta.exec(data, size)
    term.setBackgroundColor(colors.magenta)
    return data
end

return BgMAgenta