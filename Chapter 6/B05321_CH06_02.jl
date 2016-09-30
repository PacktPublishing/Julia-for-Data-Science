Pkg.clone("https://github.com/dfdx/NaiveBayes.jl.git")

using NaiveBayes
using RDatasets

iris = dataset("datasets", "iris")

# observations in columns and variables in rows
X = array(iris[:, 1:4])'
p, n = size(X)
# by default species is a PooledDataArray,
y = [species for species in iris[:, 5]]

# how much data use for training
train_frac = 0.9
k = int(floor(train_frac * n))
idxs = randperm(n)
train = idxs[1:k]
test = idxs[k+1:end]

model = GaussianNB(unique(y), p)
fit(model, X[:, train], y[train])

accuracy = countnz(predict(model, X[:,test]).==
            y[test]) / countnz(test)

println("Accuracy: $accuracy")

X = [1 1 0 2 1;
     0 0 3 1 0;
     1 0 1 0 2]

y = [:a, :b, :b, :a, :a]

m = MultinomialNB(unique(y), 3)
fit(m, X, y)


Xtest = [0 4 1;
         2 2 0;
         1 1 1]

predict(m, Xtest)
