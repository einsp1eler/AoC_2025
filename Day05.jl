import Base: occursin, length, show, isempty

struct Range 
    low::Int
    high::Int
end

occursin(needle::Int, haystack::Range) = needle >= haystack.low && needle <= haystack.high
length(r::Range) = r.high - r.low + 1
show(io::IO, r::Range) = print(io, "$(r.low)-$(r.high)")
isempty(r::Range) = r.low == 0 && r.high == 0

function combine(r1::Range, r2::Range)
    if (r1.low < r2.low && r1.high < r2.low) || (r2.low < r1.low && r2.high < r1.low)
        return Range(0, 0)
    else
        return Range(min(r1.low, r2.low), max(r1.high, r2.high))
    end
end

function combine_ranges(ranges)
    sorted_ranges = sort(ranges, by = r -> r.low)
    combined_ranges = [sorted_ranges[1]]
    for r in 2:length(sorted_ranges)
        c = combine(sorted_ranges[r], combined_ranges[end])
        if isempty(c)
            push!(combined_ranges, sorted_ranges[r])
        else
            combined_ranges[end] = c
        end
    end
    return combined_ranges
end

function part1(ranges, ingredients)
    ret = 0
    for i in ingredients
        for r in ranges
            if occursin(i, r)
                ret += 1
                break
            end
        end
    end
    return ret
end

part2(ranges) = sum(length(r) for r in combine_ranges(ranges))

lines = readlines("Input/Day05.txt")

ranges = [Range(parse(Int, split(line, "-")[1]), parse(Int, split(line, "-")[2])) for line in lines if occursin("-", line)]
ingredients = [parse(Int, line) for line in lines if !occursin("-", line) && !isempty(line)]

println(part1(ranges, ingredients))
println(part2(ranges))