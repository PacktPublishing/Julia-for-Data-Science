using DataFrames
using RDatasets
using Distributions
using Gadfly

srand(619)

names(Normal)

params(dist1)

dist1.μ

dist1.σ

x = rand(dist1, 1000)

dist2 = Truncated(dist1, -4.0, 6.0)

plot(x = rand(dist1, 1000), Geom.histogram(bincount = 30))
