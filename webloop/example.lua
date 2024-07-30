webloop(nil, body("bg-cyan w-full") {} {
    text("middle") {id="text-1"} {"Welcome to Webloop!"},
    div("w-10 bg-purple") {id="div-1"} {
        "This is a div element",
        text("text-pink") {id="text-3"} {"this is another div element"},
        text("text-green") {id="text-4"} { "This is a paragraph element"}
    },
    div("bg-red middle") {id="div-2"} {
        text {id="text-6"} {"This is a div element"},
        text {id="text-7"} {"this is another div element"},
        text {id="text-8"} {"This is a paragraph element"}
    },
    div("bg-yellow end w-20") {id="div-3"} {
        text {id="text-9"} {"This is a long div element to test wrapping and stuff"},
        link("text-blue") {"file:".. dir() .. "/example2.lua", id="link"} {"Click here"}
    },
})