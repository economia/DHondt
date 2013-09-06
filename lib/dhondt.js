(function(){
  var getRoundWinner;
  module.exports.compute = function(votes, mandateCount, options){
    var mandates, mandatesAwarded, that, winningIndex;
    options == null && (options = {});
    mandates = votes.map(function(){
      return 0;
    });
    mandatesAwarded = 0;
    if (that = options.voteAccessor) {
      votes = votes.map(that);
    }
    while (mandatesAwarded < mandateCount) {
      winningIndex = getRoundWinner(votes, mandates);
      mandates[winningIndex]++;
      mandatesAwarded++;
    }
    return mandates;
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
