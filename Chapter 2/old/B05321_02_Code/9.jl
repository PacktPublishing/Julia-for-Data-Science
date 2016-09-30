using DataFrames
datavector = @data(["A", "A", "A","B", "B", "B"])
pooleddatavector = @pdata(["A", "A", "A","B", "B", "B"])

levels(pooleddatavector)

pooleddatavector = compact(pooleddatavector)

dataframe_notpooled = DataFrame(A = [10, 10, 10, 20, 20, 20], B = ["X", "X", "X", "Y", "Y", "Y"])

pooleddf = pool!(dataframe_notpooled, [:A, :B])
