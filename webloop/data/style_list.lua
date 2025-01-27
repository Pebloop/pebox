local StyleList = {
    start = require("style.begin").exec,
    ["end"] = require("style.end").exec,
    middle = require("style.center").exec,
    -- background colors
    ["bg-white"] = require("style.bg_color").exec(colors.white),
    ["bg-black"] = require("style.bg_color").exec(colors.black),
    ["bg-orange"] = require("style.bg_color").exec(colors.orange),
    ["bg-magenta"] = require("style.bg_color").exec(colors.magenta),
    ["bg-cyan"] = require("style.bg_color").exec(colors.cyan),
    ["bg-green"] = require("style.bg_color").exec(colors.green),
    ["bg-red"] = require("style.bg_color").exec(colors.red),
    ["bg-blue"] = require("style.bg_color").exec(colors.blue),
    ["bg-yellow"] = require("style.bg_color").exec(colors.yellow),
    ["bg-purple"] = require("style.bg_color").exec(colors.purple),
    ["bg-gray"] = require("style.bg_color").exec(colors.gray),
    ["bg-light-gray"] = require("style.bg_color").exec(colors.lightGray),
    ["bg-brown"] = require("style.bg_color").exec(colors.brown),
    ["bg-lime"] = require("style.bg_color").exec(colors.lime),
    ["bg-pink"] = require("style.bg_color").exec(colors.pink),
    ["bg-light-blue"] = require("style.bg_color").exec(colors.lightBlue),
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
    ["text-light-blue"] = require("style.text_color").exec(colors.lightBlue),
    -- width
    ["w-1"] = require("style.width").exec(1),
    ["w-2"] = require("style.width").exec(2),
    ["w-3"] = require("style.width").exec(3),
    ["w-4"] = require("style.width").exec(4),
    ["w-5"] = require("style.width").exec(5),
    ["w-6"] = require("style.width").exec(6),
    ["w-7"] = require("style.width").exec(7),
    ["w-8"] = require("style.width").exec(8),
    ["w-9"] = require("style.width").exec(9),
    ["w-10"] = require("style.width").exec(10),
    ["w-15"] = require("style.width").exec(15),
    ["w-20"] = require("style.width").exec(20),
    ["w-25"] = require("style.width").exec(25),
    ["w-30"] = require("style.width").exec(30),
    ["w-35"] = require("style.width").exec(35),
    ["w-40"] = require("style.width").exec(40),
    ["w-45"] = require("style.width").exec(45),
    ["w-50"] = require("style.width").exec(50),
    ["w-55"] = require("style.width").exec(55),
    ["w-60"] = require("style.width").exec(60),
    ["w-65"] = require("style.width").exec(65),
    ["w-70"] = require("style.width").exec(70),
    ["w-75"] = require("style.width").exec(75),
    ["w-80"] = require("style.width").exec(80),
    ["w-85"] = require("style.width").exec(85),
    ["w-90"] = require("style.width").exec(90),
    ["w-95"] = require("style.width").exec(95),
    ["w-100"] = require("style.width").exec(100),
    ["w-full"] = require("style.width_full").exec,
    -- height
    ["h-1"] = require("style.height").exec(1),
    ["h-2"] = require("style.height").exec(2),
    ["h-3"] = require("style.height").exec(3),
    ["h-4"] = require("style.height").exec(4),
    ["h-5"] = require("style.height").exec(5),
    ["h-6"] = require("style.height").exec(6),
    ["h-7"] = require("style.height").exec(7),
    ["h-8"] = require("style.height").exec(8),
    ["h-9"] = require("style.height").exec(9),
    ["h-10"] = require("style.height").exec(10),
    ["h-15"] = require("style.height").exec(15),
    ["h-20"] = require("style.height").exec(20),
    ["h-25"] = require("style.height").exec(25),
    ["h-30"] = require("style.height").exec(30),
    ["h-35"] = require("style.height").exec(35),
    ["h-40"] = require("style.height").exec(40),
    ["h-45"] = require("style.height").exec(45),
    ["h-50"] = require("style.height").exec(50),
    ["h-55"] = require("style.height").exec(55),
    ["h-60"] = require("style.height").exec(60),
    ["h-65"] = require("style.height").exec(65),
    ["h-70"] = require("style.height").exec(70),
    ["h-75"] = require("style.height").exec(75),
    ["h-80"] = require("style.height").exec(80),
    ["h-85"] = require("style.height").exec(85),
    ["h-90"] = require("style.height").exec(90),
    ["h-95"] = require("style.height").exec(95),
    ["h-100"] = require("style.height").exec(100),
    ["h-full"] = require("style.height_full").exec,
}

return StyleList