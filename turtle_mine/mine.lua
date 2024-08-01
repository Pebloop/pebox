local args = { ... }
local width = tonumber(args[1])
local depth = tonumber(args[2])
local height = tonumber(args[3])

turtle.refuel()

for i = 1, height do
    for j = 1, width do
        for k = 1, depth do
            turtle.refuel()
            turtle.dig()
            turtle.forward()
        end

        print(j)
        if j < width then
            if j % 2 == 0 then
                turtle.turnRight()
                turtle.dig()
                turtle.forward()
                turtle.turnRight()
            else
                turtle.turnLeft()
                turtle.dig()
                turtle.forward()
                turtle.turnLeft()
            end
        end
    end
    turtle.digDown()
    turtle.down()

    if i % 2 == 0 then
        turtle.turnRight()
        turtle.turnRight()
    else
        turtle.turnLeft()
        turtle.turnLeft()
    end
end
