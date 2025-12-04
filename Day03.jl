function solve(banks, x)
    ret = 0
    for bank in banks
        nums = [maximum(bank[1:end-x])]
        for i in x-1:-1:0
            bank = bank[findfirst(==(nums[x-i]), bank)+1:end]
            push!(nums, maximum(bank[1:end-i]))
        end
        ret += parse(Int, join(nums))
    end
    return ret
end

banks = readlines("Input/Day03.txt")

println(solve(banks, 1))
println(solve(banks, 11))