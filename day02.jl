
# fname = "./inputs/02_example.txt"
# fname = "./inputs/02b_example.txt"
fname = "./inputs/02.txt"

function gamedata(fname)
    data = []
    for line in readlines(fname)
        draws = []
        gamestr, drawsinfo = split(line, ":")
        game = parse(Int, split(gamestr, " ")[2])
        reg = r"([0-9]+ (red|green|blue))"
        for drawinfo in split(drawsinfo, ";")
            draw = Dict("red"=>0, "green"=>0, "blue"=>0)
            for mat in eachmatch(reg, drawinfo)
                countstr, color = split(mat.match, " ")
                count = parse(Int, countstr)
                draw[color] = count
            end
            push!(draws, draw)
        end
        # println((game, draws))
        push!(data, (game, draws))
    end
    return data
end

possible = Dict("red" => 12, "green" => 13, "blue" => 14)
gd = gamedata(fname)
valid_games = []
for (gnum, draws) in gd
    maxes = Dict("red" => 0, "green" => 0, "blue" => 0)
    for draw in draws
        for (color, count) in pairs(draw)
            maxes[color] = maximum((maxes[color], draw[color]))
        end
    end
    if all(maxes[col] <= possible[col] for col in keys(possible))
        push!(valid_games, gnum)
    end
end
println(sum(valid_games)) # part 1 answer

### part 2
powers = []
for (gnum, draws) in gd
    maxes = Dict("red" => 0, "green" => 0, "blue" => 0)
    for draw in draws
        for (color, count) in pairs(draw)
            maxes[color] = maximum((maxes[color], draw[color]))
        end
    end
    pow = reduce(*, values(maxes))
    push!(powers, pow)
end
println(sum(powers))