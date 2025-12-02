function check_duplicates(num, a, b)
    b > length(num) && return parse(Int, num)
    num[a] != num[b] && return 0
    return check_duplicates(num, a + 1, b + 1)
end

function part1(num)
    isodd(length(num)) && return 0
    return check_duplicates(num, 1, div(length(num), 2) + 1)
end

function part2(num)
    len = length(num)
    if all(x == num[1] for x in num) && len > 1
        return parse(Int, num)
    elseif len == 2
        return num[1] == num[2] ? parse(Int, num) : 0
    end
    for i in 2:div(len, 2)
        if len % i == 0 && all(check_duplicates(num[j:j+2*i-1], 1, i + 1) > 0 for j in 1:i:(len - i))
            return parse(Int, num)
        end
    end
    return 0
end

pairs = [(split(x, "-")[1], split(x, "-")[2]) for line in readlines("Input/Day02.txt") for x in split(line, ",")]

println(sum(part1(string(i)) for pair in pairs for i in parse(Int, pair[1]):parse(Int, pair[2])))
println(sum(part2(string(i)) for pair in pairs for i in parse(Int, pair[1]):parse(Int, pair[2])))