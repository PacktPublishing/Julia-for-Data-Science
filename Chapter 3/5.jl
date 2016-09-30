using StatsBase
using RDatasets
a = [123,4234,23423,1231231,1432432423,1341413413]
var(a)
var(a, 2)
std(a)
mean_and_var(a)
mean_and_std(a)
skewness(a)
kurtosis(a)
moment(a,3)
span(a)
variation(a)
