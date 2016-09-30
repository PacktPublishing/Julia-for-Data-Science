using StatsBase
using RDatasets
using Distributions
using Gadfly
sleep = dataset("lme4","sleepstudy")
plot(x = sleep[:Reaction], Geom.histogram(bincount = 30), color = sleep[:Days])
plot(sleep, x = "Days", y = "Reaction", Geom.point)
plot(sleep, x = "Reaction", Geom.density, color = "Subject")

plot([sin, cos], 0, 25)

plot(dataset("datasets", "iris"),x="SepalLength", y="SepalWidth", Geom.point)
