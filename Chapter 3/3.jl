using StatsBase
using RDatasets
iris_dataframe = dataset("datasets", "iris")
head(iris_dataframe)
typeof(iris_dataframe[1,:Species])
describe(iris_dataframe)
