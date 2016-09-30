
using DecisionTree
using ScikitLearn
using PyPlot

# Create a random dataset
srand(100)
X = sort(5 * rand(80))
XX = reshape(X, 80, 1)
y = sin(X)
y[1:5:end] += 3 * (0.5 - rand(16))

# Fit regression model
regr_1 = DecisionTreeRegressor()
regr_2 = DecisionTreeRegressor(pruning_purity_threshold=0.05)

fit!(regr_1, XX, y)

fit!(regr_2, XX, y)

# Predict
X_test = 0:0.01:5.0
y_1 = predict(regr_1, hcat(X_test))
y_2 = predict(regr_2, hcat(X_test))

# Plot the results
scatter(X, y, c="k", label="data")
plot(X_test, y_1, c="g", label="no pruning", linewidth=2)
plot(X_test, y_2, c="r", label="pruning_purity_threshold=0.05", linewidth=2)

xlabel("data")
ylabel("target")
title("Decision Tree Regression")
legend(prop=Dict("size"=>10))
