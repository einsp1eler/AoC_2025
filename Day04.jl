in_bounds(x, s) = x > 0 && x <= s

get_adjacent(grid, i, j) = [grid[ii][jj] for ii in i-1:i+1, jj in j-1:j+1 
                            if in_bounds(ii, length(grid)) && in_bounds(jj, length(grid)) && !(ii == i && jj == j)]

function solve(grid, part)
    ret = 0
    for i in eachindex(grid), j in eachindex(grid[i])
        if grid[i][j] == '@' && count(==('@'), get_adjacent(grid, i, j)) < 4
            part == 2 && (grid[i][j] = '.')
            ret += 1
        end
    end
    return ret
end

part1(grid) = solve(grid, 1)

function part2(grid)
    ret = 0
    while (added = solve(grid, 2)) > 0
        ret += added
    end
    return ret
end

grid = [collect(line) for line in readlines("Input/Day04.txt")]

println(part1(grid))
println(part2(grid))