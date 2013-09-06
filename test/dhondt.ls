require! {
    expect : "expect.js"
    '../lib/dhondt'
}

test = it
describe \DHondt ->
    test 'should compute test case' ->
        # http://cs.wikipedia.org/wiki/D'Hondtova_metoda
        votes = [83647 63181 24823 20646 9131]
        mandates = 8
        result = dhondt.compute votes, mandates
        expect result .to.eql [4 3 1 0 0]

    test 'shound handle vote accessors' ->
        # http://en.wikipedia.org/wiki/D'Hondt_method
        parties =
            *   party: \A
                votes: 100000
            *   party: \B
                votes:  80000
            *   party: \C
                votes:  30000
            *   party: \D
                votes:  20000
        mandates = 8
        result = dhondt.compute do
            parties
            mandates
            voteAccessor: (.votes)
        expect result .to.eql [4 3 1 0]


    test 'shound handle result accessors' ->
        # http://en.wikipedia.org/wiki/D'Hondt_method
        parties =
            *   party: \A
                votes: 100000
            *   party: \B
                votes:  80000
            *   party: \C
                votes:  30000
            *   party: \D
                votes:  20000
        mandates = 8
        dhondt.compute do
            *   parties
            *   mandates
            *   voteAccessor: (.votes)
                resultProperty: "result"
        expect parties.0.result .to.equal 4
        expect parties.1.result .to.equal 3
        expect parties.2.result .to.equal 1
        expect parties.3.result .to.equal 0

