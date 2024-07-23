local StyleList = {
    start = require("style.begin").exec,
    ["end"] = require("style.end").exec,
    middle = require("style.center").exec,
    ["bg-white"] = require("style.backgrounds.bg_white").exec,
    ["bg-black"] = require("style.backgrounds.bg_black").exec,
    ["bg-orange"] = require("style.backgrounds.bg_orange").exec,
    ["bg-magenta"] = require("style.backgrounds.bg_magenta").exec
    ["bg-cyan"] = require("style.backgrounds.bg_cyan").exec,
    ["bg-green"] = require("style.backgrounds.bg_green").exec,
    ["bg-red"] = require("style.backgrounds.bg_red").exec,
    ["bg-blue"] = require("style.backgrounds.bg_blue").exec,
    ["bg-yellow"] = require("style.backgrounds.bg_yellow").exec,
    ["bg-purple"] = require("style.backgrounds.bg_purple").exec,
    ["bg-gray"] = require("style.backgrounds.bg_gray").exec,
    ["bg-light-gray"] = require("style.backgrounds.bg_light_gray").exec,
    ["bg-brown"] = require("style.backgrounds.bg_brown").exec,
    ["bg-lime"] = require("style.backgrounds.bg_lime").exec,
    ["bg-pink"] = require("style.backgrounds.bg_pink").exec,
    ["bg-light-blue"] = require("style.backgrounds.bg_light_blue").exec
}

return StyleList