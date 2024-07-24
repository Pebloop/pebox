webloop(nil, body("", {
    text("text-green", "Left"),
    text("middle bg-magenta", "Center"),
    text("end bg-orange", "Right"),
    div ("w-10 bg-magenta", {
        text("text-blue", "a text in a very long magenta box :o"),
        text("text-purple end", "another element")
    }),
    text("w-10 h-2 end", "a text is truncated by the box :<"),
    })
)