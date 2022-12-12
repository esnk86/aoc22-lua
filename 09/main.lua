local knots = {}

local visited = setmetatable({}, {__index = function(t, k)
    rawset(t, k, {})
    return rawget(t, k)
end})

local function touching(p1, p2)
    return math.abs(p1.x - p2.x) <= 1 and math.abs(p1.y - p2.y) <= 1
end

local function compare(a, b)
    if a < b then
        return -1
    elseif a > b then
        return 1
    else
        return 0
    end
end

local function update_tails()
    for i = 2, #knots do
        local head = knots[i - 1]
        local tail = knots[i]
        while not touching(head, tail) do
            tail.x = tail.x + compare(head.x, tail.x)
            tail.y = tail.y + compare(head.y, tail.y)
            if i == #knots then visited[tail.x][tail.y] = true end
        end
    end
end

local function update_head(line)
    local direction, steps = line:match('([UDLR]) (%d+)')
    for i = 1, tonumber(steps) do
        if direction == 'U' then knots[1].y = knots[1].y + 1 end
        if direction == 'D' then knots[1].y = knots[1].y - 1 end
        if direction == 'L' then knots[1].x = knots[1].x - 1 end
        if direction == 'R' then knots[1].x = knots[1].x + 1 end
        update_tails()
    end
end

local function main()
    local problem = tonumber(arg[1])

    for i = 1, ({2, 10})[problem] do
        knots[i] = {x = 0, y = 0}
    end

    visited[0][0] = true

    for line in io.lines() do
        update_head(line)
    end

    local count = 0
    for _, x in pairs(visited) do
        for _ in pairs(x) do
            count = count + 1
        end
    end
    print(count)
end

main()
