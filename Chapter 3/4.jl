using StatsBase
using RDatasets
a = [123,4234,23423,1231231,1432432423,1341413413]
geomean(a)
harmmean(a)
trimmean(a,0.1)

wv = rand(6)
mean(a, weights(wv))
