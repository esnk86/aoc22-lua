local function parse(line)
    local hand, response = line:match('([ABC]) ([XYZ])')

    hand = ('ABC'):find(hand)
    response = ('XYZ'):find(response)

    return hand, response
end

local function score(problem, hand, response)
    if problem == 1 then
        return response + 3 * ((math.abs(response - hand + 2) - 1) % 3)
    else
        return 3 * (response - 1) + (hand + response) % 3 + 1
    end
end

local lines = {}

for line in io.lines() do
    table.insert(lines, line)
end

for problem = 1, 2 do
    local sum = 0
    for _, line in ipairs(lines) do
        sum = sum + score(problem, parse(line))
    end
    print(sum)
end
