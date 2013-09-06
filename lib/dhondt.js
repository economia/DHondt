(function(){
  var getRoundWinner;
  module.exports.compute = function(partyArray, mandateCount, options){
    var mandates, mandatesAwarded, votes, that, winningIndex;
    options == null && (options = {});
    mandates = partyArray.map(function(){
      return 0;
    });
    mandatesAwarded = 0;
    votes = (function(){
      switch (false) {
      case !(that = options.voteAccessor):
        return partyArray.map(that);
      default:
        return partyArray;
      }
    }());
    if (that = options.resultProperty) {
      partyArray.forEach(function(it){
        return it[that] = 0;
      });
    }
    while (mandatesAwarded < mandateCount) {
      winningIndex = getRoundWinner(votes, mandates);
      mandates[winningIndex]++;
      if (that = options.resultProperty) {
        partyArray[winningIndex][that]++;
      }
      mandatesAwarded++;
    }
    switch (false) {
    case !options.resultProperty:
      return partyArray;
    default:
      return mandates;
    }
  };
  getRoundWinner = function(votes, mandates){
    var highestIndex, highestScore, i$, len$, index, voteCount, mandateCount, score;
    highestIndex = -1;
    highestScore = -Infinity;
    for (i$ = 0, len$ = votes.length; i$ < len$; ++i$) {
      index = i$;
      voteCount = votes[i$];
      mandateCount = mandates[index];
      score = voteCount / (mandateCount + 1);
      if (score > highestScore) {
        highestScore = score;
        highestIndex = index;
      }
    }
    return highestIndex;
  };
}).call(this);
