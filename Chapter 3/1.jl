Pkg.update()
Pkg.add("StatsBase")
using StatsBase
using RDatasets
iris_dataframe = dataset("datasets", "iris")
sample(iris_dataframe[:SepalLength], 5)
