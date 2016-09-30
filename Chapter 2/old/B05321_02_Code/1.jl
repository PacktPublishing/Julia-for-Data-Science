Pkg.update()
Pkg.add("DataFrames")
x = DataArray([1.1, 2.2, 3.3, 4.4, 5.5, 6.6])
x[1] = NA
true || x
mean(x)
mean(x[2:6])
