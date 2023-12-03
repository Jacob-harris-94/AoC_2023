
# fname = "./inputs/01_example.txt"
# fname = "./inputs/01b_example.txt"
fname = "./inputs/01.txt"

# println(String(read(fname)))

sum = 0
for (num, line) in enumerate((readlines(fname)))
    # println("line $num\tcontents:\"$line\"")
    digits_in_line = [char for char in line if char in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']]
    # println(digits_in_line)
    sum += parse(Int, (first(digits_in_line)*last(digits_in_line)))
end

println(sum)

### part 2

# function dil(line::String)
#     replace_pairs = ["zero" => "0", "one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9"]
#     fixed = replace(line, replace_pairs...)    
#     digits_in_line = [char for char in fixed if char in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] || char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]]
#     return digits_in_line
# end

function dil(line::String)
    reg = r"[0-9]|(zero)|(two)|(four)|(six)|(eight)|(nine)|(one)|(three)|(five)|(seven)"
    num_lookup = Dict(["zero" => "0", "one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9"])
    digits = []
    for mat in eachmatch(reg, line; overlap=true)
        match = mat.match
        if match in keys(num_lookup)
            match = num_lookup[match]
        end
        push!(digits, match)
    end
    return digits
end

dil("one") == dil("1") # #== ["1"]
dil("onetwo") == dil("12")

# should this be true?
dil("eightwo") == dil("8") # see 319, 458, 556, 561, 590, ...
dil("twone") == dil("2") # see 196, 199

lines = []
digits_in_lines = []
sum = 0
for (num, line) in enumerate((readlines(fname)))
    push!(lines, line)
    digits_in_line = dil(line)
    push!(digits_in_lines, (first(digits_in_line)*last(digits_in_line)))
    sum += parse(Int, (first(digits_in_line)*last(digits_in_line)))
end

println(sum)


