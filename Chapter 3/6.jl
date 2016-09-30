using StatsBase
using RDatasets
using Distributions
d = Dirichlet([1.0, 3.0, 5.0])
arr=rand(d)
entropy(arr,2)
entropy(arr)
