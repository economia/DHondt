module.exports.compute = (partyArray, mandateCount, options = {}) ->
    mandates = partyArray.map -> 0
    mandatesAwarded = 0
    votes =
        | options.voteAccessor => partyArray.map that
        | otherwise            => partyArray
    if options.resultProperty then partyArray.forEach -> it[that] = 0
    while mandatesAwarded < mandateCount
        winningIndex = getRoundWinner votes, mandates
        mandates[winningIndex]++
        if options.resultProperty then partyArray[winningIndex][that]++
        mandatesAwarded++

    switch
    | options.resultProperty => partyArray
    | otherwise              => mandates

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
