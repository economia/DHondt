module.exports.compute = (partyArray, mandateCount, options = {}) ->
    options.base ?= 1
    mandates = partyArray.map -> 0
    mandatesAwarded = 0
    votes =
        | options.voteAccessor => partyArray.map that
        | otherwise            => partyArray
    if options.resultProperty then partyArray.forEach -> it[that] = 0
    while mandatesAwarded < mandateCount
        winningIndex = getRoundWinner votes, mandates, options
        mandates[winningIndex]++
        if options.resultProperty then partyArray[winningIndex][that]++
        mandatesAwarded++

    switch
    | options.resultProperty => partyArray
    | otherwise              => mandates

getRoundWinner = (votes, mandates, options) ->
    highestIndex = -1
    highestScore = -Infinity
    for voteCount, index in votes
        mandateCount = mandates[index]
        divider = if mandateCount then that + 1 else options.base
        score = voteCount / divider
        if score > highestScore
            highestScore = score
            highestIndex = index
    highestIndex
