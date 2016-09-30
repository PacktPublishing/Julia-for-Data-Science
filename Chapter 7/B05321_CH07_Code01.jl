
Pkg.add("Clustering")

Pkg.update()

using Clustering
using RDatasets

xclara = dataset("cluster", "xclara")

names!(xclara, [symbol(i) for i in ["x", "y"]])

using Clustering
using Gadfly
iris = dataset("datasets", "iris")
features = array(iris[:, 1:4])'
# group the data onto 3 clusters
result = kmeans( features, 3 )
plot(iris, x = "PetalLength", y = "PetalWidth",
        color = result.assignments, Geom.point)


