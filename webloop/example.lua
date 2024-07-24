webloop(nil, body("", {
    text("", "Left"),
    text("middle bg-magenta", "Center"),
    text("end bg-orange", "Right"),
    div ("w-10 h-2 bg-magenta", {
        text("", "a text in a very long magenta box :o"),
    }),
    text("w-10 h-2 end", "a text is truncated by the box :<"),
    })
)