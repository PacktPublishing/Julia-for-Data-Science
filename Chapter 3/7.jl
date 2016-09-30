using StatsBase
using RDatasets
using Distributions
a = rand(4)
ordinalrank(a)
a = rand([1:5],30)
counts(a)
proportions(a,1:3)
countmap(a)
proportionmap(a)
