# fname = "./inputs/03_example.txt"
# fname = "./inputs/03b_example.txt"
fname = "./inputs/03.txt"

uniquechars = Set()
num_pos = []
sym_pos = []
star_pos = []
numrows = 0
numcols = 0
for (linenum, line) in enumerate(readlines(fname))
    for char in line
        push!(uniquechars, char)
    end
    push!(chararrays, collect(line))
    sym_reg = r"(\*|#|\+|\$|\&|\%|/|@|=|-)"
    for mat in findall(sym_reg, line)
        col = collect(mat)[1]
        row = linenum
        push!(sym_pos, (row, col))
        if line[mat] == "*"
            push!(star_pos, (row, col))
        end
    end
    numrows = linenum
    numcols = length(line)
end

function getadj(row, col, numrows, numcols)
    # includes redundant (row, col) but that doesn't matter
    outputpairs = []
    for rowoffset in [-1, 0, 1], coloffset in [-1, 0, 1]
        newrow = row + rowoffset
        newcol = col + coloffset
        if 1 <= newrow <= numrows && 1 <= newcol <= numcols
            push!(outputpairs, (newrow, newcol))
        end
    end
    return outputpairs
end

nums = []
for (linenum, line) in enumerate(readlines(fname))
    for char in line
        push!(uniquechars, char)
    end
    num_reg = r"([0-9]+)"
    for mat in findall(num_reg, line)
        cols = collect(mat)
        row = linenum
        val = parse(Int, line[mat])
        push!(num_pos, (row, cols, val))
        if any(any(adj in sym_pos for adj in getadj(row, col, numrows, numcols)) for col in cols)
            push!(nums, val)
        end
    end
end

function isadj(r, c, r2, c2)
    return abs(r2-r) <= 1 && abs(c2-c) <= 1
end

gearratios = []
for (r, c) in star_pos
    matches = []
    for (r2, c2s, num) in num_pos
        if any(isadj(r, c, r2, c2) for c2 in c2s)
            push!(matches, num)
        end
    end
    if length(matches) == 2
        push!(gearratios, matches[1] * matches[2])
    end
end

println(sum(nums)) # part 1
println(sum(gearratios)) # part 2



