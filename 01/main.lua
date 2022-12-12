local cals = {0}

for line in io.lines() do
    if #line > 0 then
        cals[#cals] = cals[#cals] + tonumber(line)
    else
        table.insert(cals, 0)
    end
end

table.sort(cals)

print(cals[#cals])

local sum = 0
for i = 0, 2 do sum = sum + cals[#cals - i] end
print(sum)
