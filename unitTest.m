function tests = unitTest
    tests = functiontests(localfunctions);
end

function pitchExtractionTest(testCase)
    pitchExtraction('Bethoven C#m.wav')
end

function bsefreqtryTest(testCase)
    bsefreqtry('Bethoven C#m.wav')
end

function errorfreqTest(testCase)
    [entrada,t,freq,freqn] = bsefreqtry('Bethoven C#m.wav')
    errorf=[34.6500 38.8900 41.2000 46.2500 55.0000];
    errorfreq(freqn,errorf)
end