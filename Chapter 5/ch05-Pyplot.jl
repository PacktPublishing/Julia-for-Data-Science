
using PyPlot
PyPlot.svg(true)

x = [1:100]
y = [i^2 for i in x]
p = plot(x,y)
xlabel("X")
ylabel("Y")
title("Basic plot")
grid("on")

x = linspace(0, 3pi, 1000)
y = cos(2*x + 3*sin(3*x));
plot(x, y, color="orange", linewidth=2.0, linestyle="--");
title("Another plot using sine and cosine");







X = linspace(0, 2 * pi, 100)
Ya = sin(X)
Yb = cos(X)

plot(X, Ya)
plot(X, Yb)
show()

Pkg.add("UnicodePlots")

using UnicodePlots

myPlot = lineplot([1, 2, 3, 7], [1, 2, -5, 7], title="My Plot", border=:dotted)

myPlot = densityplot([1:100], randn(100), border=:dotted)

using ASCIIPlots

x = collect(-pi:0.2:pi)
lineplot(x, sin(x))

using Vega

x = [0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9]
y = [28, 43, 81, 19, 52, 24, 87, 17, 68, 49, 55, 91, 53, 87, 48, 49, 66, 27, 16, 15]
g = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1]

a = areaplot(x = x, y = y, group = g, stacked = true)

fruit = ["peaches", "plums", "blueberries", "strawberries", "bananas"];
bushels = [100, 32, 180, 46, 21];
piechart(x = fruit, y = bushels, holesize = 125)

using Bokeh
using Dates # for version 0.3

start = Date(2015, 6, 21)
days = 120
x = map(d -> start + Dates.Day(d), 1:days)
y = 15 + randn(days) * 4
plot(x, y, title="A typical British Summer", legends=["Temperature"])


