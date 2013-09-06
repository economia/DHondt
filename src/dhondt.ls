module.exports.compute = (votes, mandateCount) ->
    mandates = votes.map -> 0
    mandatesAwarded = 0
    while mandatesAwarded < mandateCount
        winningIndex = getRoundWinner votes, mandates
        mandates[winningIndex]++
        mandatesAwarded++
    mandates

getRoundWinner = (votes, mandates) ->
    highestIndex = -1
    highestScore = -Infinity
    for voteCount, index in votes
        mandateCount = mandates[index]
        score = voteCount / (mandateCount + 1)
        if score > highestScore
            highestScore = score
            highestIndex = index
    highestIndex
