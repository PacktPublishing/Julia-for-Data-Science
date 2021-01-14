using RDatasets
using DataFrames
random_dataframe = DataFrame(A = randn(5), B = randn(5), C = randn(5))
random_modelframe = ModelFrame(@formula(A ~ B + C), random_dataframe)
random_modelmatrix = ModelMatrix(ModelFrame(@formula(A ~ B + C), random_dataframe))
