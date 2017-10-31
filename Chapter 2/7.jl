using RDatasets, DataFrames
iris_dataframe = dataset("datasets", "iris")

iris_dataframe[:id] = 1:size(iris_dataframe, 1)
iris_stack = stack(iris_dataframe, [1:4])

iris_stack_petal = stack(iris_dataframe, [:PetalLength, :PetalWidth], :Species)

iris_melt = melt(iris_dataframe, :Species)

iris_default_stack = stack(iris_dataframe)
