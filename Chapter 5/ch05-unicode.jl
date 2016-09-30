
using UnicodePlots

scatterplot(randn(50), randn(50),
    title = "My Scatterplot")

myPlot = densityplot([1:100], randn(100), border=:dotted)

lineplot(rand(3), rand(3), title = "My Lineplot")


