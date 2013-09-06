require! {
    child_process.exec
    fs
}
option 'testFile' 'File in (/lib or /test) to run test on' 'FILE'

task \test ({testFile = 'src/dhondt.ls'}) ->
    relativeAddress = testFile.replace __dirname, '' .substr 1

    [srcOrTest, ...fileAddress] = relativeAddress.split /[\\\/]/
    fileAddress .= join '/'
    (err, stdout, stderr) <~ exec "lsc -o #__dirname/lib -c #__dirname/src"
    throw stderr if stderr
    (err, stdout, stderr) <~ exec "mocha --compilers ls:livescript -R tap --bail #__dirname/test/#fileAddress"
    niceTestOutput stdout, stderr

niceTestOutput = (test, stderr) ->
    lines         = test.split "\n"
    oks           = 0
    fails         = 0
    out           = []
    shortOut      = []
    disabledTests = []
    for line in lines
        if 'ok' == line.substr 0, 2
            ++oks
        else if 'not' == line.substr 0,3
            ++fails
            out.push line
            shortOut.push line.match(/not ok [0-9]+ (.*)$/)[1]
        else if 'Disabled' == line.substr 0 8
            disabledTests.push line
        else if line and ('#' != line.substr 0, 1) and ('1..' != line.substr 0, 3)
            console.log line
    if oks && !fails
        console.log "Tests OK (#{oks})"
        disabledTests.forEach -> console.log it
    else
        #console.log "!!!!!!!!!!!!!!!!!!!!!!!    #{fails}    !!!!!!!!!!!!!!!!!!!!!!!"
        if out.length
            console.log shortOut.join ", "#line for line in shortOut
        else
            console.log "Tests did not run (error in testfile?)"
            console.log test
            console.log stderr

getAddressParts = (filename) ->
    | /[\\\/]apyca[\\\/]((.+)\.ls)$/i is filename
        [server, libOrTest, ...address] = that.1.split /[\\\/]/
        address .= join '/'
        {server, libOrTest, address}
