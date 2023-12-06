# fname = "./inputs/04_example.txt"
# fname = "./inputs/04b_example.txt"
fname = "./inputs/04.txt"

pointstotal = 0
cards_matches = []
for (linenum, line) in enumerate(readlines(fname))
    winning = []
    having = []
    card, nums = strip.(split(line, ": "))
    wins, haves = strip.(split(nums, "|"))
    for w in strip.(split(wins, " "))
        if !isempty(w)
            push!(winning, parse(Int, w))
        end
    end
    for h in strip.(split(haves, " "))
        if !isempty(h)
            push!(having, parse(Int, h))
        end
    end
    matchcount = sum(h in winning for h in having)
    points = 0
    if matchcount > 0
        points = 2^(matchcount-1)
    end
    pointstotal += points
    push!(cards_matches, (linenum, matchcount))
end
println(pointstotal) # part 1

counts = ones(Int, length(cards_matches))
for (ii, matchcount) in cards_matches
    for jj in (ii+1):(ii+matchcount)
        counts[jj] += counts[ii]
    end
end
println(sum(counts)) # part 2


# attempt at recursion
# if you win a copy of a card, that card's cardcount is added to the current card... ???
# total_cards[ii] = 1 + sum[totals_cards[jj] for jj in (ii+1):(ii+matches)]
# total_cards(last) = 1
# function totalcards(ii, cardsmatches)
#     if ii == length(cardsmatches)
#         return 1
#     end
#     matches = cardsmatches[ii][2]
#     if matches == 0
#         return 1 + totalcards(ii+1, cardsmatches)
#     else
#         return 1 + sum(totalcards(jj, cardsmatches) for jj in (ii+1):(ii+matches))
#     end
# end
# [(totalcards(idx, cards_matches), cards_matches[idx]) for idx in 1:length(cards_matches)]

# attempt at DP
# scores = zeros(Int, length(cards_matches))
# scores[end] = 1
# for (ii, matchcount) in reverse(cards_matches[1:end-1])
#     println((ii, matchcount))
#     if matchcount > 0
#         scores[ii] += sum(cards_matches[jj][2] for jj in (ii+1):(ii+matchcount))
#     else
#         scores[ii] = 1
#         scores[ii] += scores[ii+1]
#     end 
# end
# println(scores)
