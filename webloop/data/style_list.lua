local StyleList = {
    start = require("style.begin").exec,
    ["end"] = require("style.end").exec,
    middle = require("style.center").exec,
    -- background colors
    ["bg-white"] = require("style.backgrounds.bg_color").exec(colors.white),
    ["bg-black"] = require("style.backgrounds.bg_color").exec(colors.black),
    ["bg-orange"] = require("style.backgrounds.bg_color").exec(colors.orange),
    ["bg-magenta"] = require("style.backgrounds.bg_color").exec(colors.magenta),
    ["bg-cyan"] = require("style.backgrounds.bg_color").exec(colors.cyan),
    ["bg-green"] = require("style.backgrounds.bg_color").exec(colors.green),
    ["bg-red"] = require("style.backgrounds.bg_color").exec(colors.red),
    ["bg-blue"] = require("style.backgrounds.bg_color").exec(colors.blue),
    ["bg-yellow"] = require("style.backgrounds.bg_color").exec(colors.yellow),
    ["bg-purple"] = require("style.backgrounds.bg_color").exec(colors.purple),
    ["bg-gray"] = require("style.backgrounds.bg_gray").exec,
    ["bg-light-gray"] = require("style.backgrounds.bg_color").exec(colors.lightGray),
    ["bg-brown"] = require("style.backgrounds.bg_color").exec(colors.brown),
    ["bg-lime"] = require("style.backgrounds.bg_color").exec(colors.lime),
    ["bg-pink"] = require("style.backgrounds.bg_color").exec(colors.pink),
    ["bg-light-blue"] = require("style.backgrounds.bg_color").exec(colors.lightBlue),
    -- text colors
    ["text-white"] = require("style.text_color").exec(colors.white),
    ["text-black"] = require("style.text_color").exec(colors.black),
    ["text-orange"] = require("style.text_color").exec(colors.orange),
    ["text-magenta"] = require("style.text_color").exec(colors.magenta),
    ["text-cyan"] = require("style.text_color").exec(colors.cyan),
    ["text-green"] = require("style.text_color").exec(colors.green),
    ["text-red"] = require("style.text_color").exec(colors.red),
    ["text-blue"] = require("style.text_color").exec(colors.blue),
    ["text-yellow"] = require("style.text_color").exec(colors.yellow),
    ["text-purple"] = require("style.text_color").exec(colors.purple),
    ["text-gray"] = require("style.text_color").exec(colors.gray),
    ["text-light-gray"] = require("style.text_color").exec(colors.lightGray),
    ["text-brown"] = require("style.text_color").exec(colors.brown),
    ["text-lime"] = require("style.text_color").exec(colors.lime),
    ["text-pink"] = require("style.text_color").exec(colors.pink),
    ["text-light-blue"] = require("style.text_color").exec(colors.lightBlue)
}

return StyleList