# D'Hondt
D'Hondt is a utility that computes election results and outputs number of mandates each party received. See [D'Hondt method](http://en.wikipedia.org/wiki/D'Hondt_method) wiki page for details on how the D'Hondt algorithm works.
##API
    dhondt.compute(votes, mandates [, options])

* **votes** is an array of how many votes each party has received or an array of object if you specify options.voteAccessor function (see examples)
* **mandates** is an integer, how many mandates are being allocated
* **options** object can have following properties:
    * **voteAccessor:** function returning the number of votes from an object
    * **resultProperty:** if array of objects is passed, specifies which property of the object should house the result. If not specified, array of mandates is returned
    * **base:** Specifies the base divider used in first round of mandate allocation. Sometimes 1.42 is used to favor large parties is smaller districts.

## Examples
    var dhondt = require ('dhondt')
    var votes = [100000, 80000, 30000, 20000];
    var mandates = 8;
    var results = dhondt.compute(votes, mandates);
    console.log(results);
    // [ 4, 3, 1, 0 ]

    var parties = [
        {party: "A", votes: 100},
        {party: "B", votes:  60},
        {party: "C", votes:  45}
    ];
    var mandates = 2;
    options = {
        voteAccessor: function(object) {return object.votes},
        resultProperty: "mandates",
        base: 1.42
    }
    var results = dhondt.compute(parties, mandates, options);
    console.log(results);
    // [ { party: 'A', votes: 100, mandates: 2 },
    //   { party: 'B', votes: 60, mandates: 0 },
    //   { party: 'C', votes: 45, mandates: 0 } ]
