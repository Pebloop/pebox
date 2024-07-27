local ElementList = {
    body = require("elements.body").exec,
    text = require("elements.text").exec("text"),
    div = require("elements.body").exec,
    link = require("elements.text").exec("link"),
}

return ElementList