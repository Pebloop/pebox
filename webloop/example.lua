webloop(nil, body("bg-cyan w-screen") {
    text("middle") {"Welcome to Webloop!"},
    div("w-10 bg-purple") {
        "This is a div element",
        text("text-pink") {"this is another div element"},
        text("text-green") { "This is a paragraph element"}
    },
    div("bg-red middle") {
        {"This is a div element"},
        {"this is another div element"},
        { "This is a paragraph element"}
    }
})