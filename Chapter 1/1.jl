using DataFrames, Gadfly
p = plot(x=randn(2000), Geom.histogram(bincount=100))
