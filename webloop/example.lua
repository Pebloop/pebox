webloop(nil, body("", {
    text("", "Left"),
    text("middle bg-magenta", "Center"),
    text("end bg-orange", "Right"),
    text("w-10", "a text in a very long magenta box :o"),
    text("w-10 h-2", "a text is truncated by the box :<")
    })
)