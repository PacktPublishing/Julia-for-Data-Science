
using Vega

scatterplot(x = rand(100), y = rand(100))

using Vega, Distributions

d1 = MultivariateNormal([0.0, 0.0], [1.0 0.9; 0.9 1.0])
d2 = MultivariateNormal([10.0, 10.0], [4.0 0.5; 0.5 4.0])
points = vcat(rand(d1, 500)', rand(d2, 500)')

x = points[:, 1]
y = points[:, 2]
group = vcat(ones(Int, 500), ones(Int, 500) + 1)

scatterplot(x = x, y = y, group = group)

x = [0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9]
y = [28, 43, 81, 19, 52, 24, 87, 17, 68, 49, 55, 91, 53, 87, 48, 49, 66, 27, 16, 15]
g = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1]

a = areaplot(x = x, y = y, group = g, stacked = true)

fruit = ["peaches", "plums", "blueberries", "strawberries", "bananas"];
bushels = [100, 32, 180, 46, 21];
piechart(x = fruit, y = bushels, holesize = 125)

x = Array(Int, 900)
y = Array(Int, 900)
color = Array(Float64, 900)
tmp = 0
for counter in 1:30
    for counter2 in 1:30
        tmp += 1
        x[tmp] = counter
        y[tmp] = counter2
        color[tmp] = rand()
    end
end
hm = heatmap(x = x, y = y, color = color)


