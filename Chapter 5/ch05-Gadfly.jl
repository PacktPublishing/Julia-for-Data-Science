
using Gadfly

p = plot(x=randn(2000), Geom.histogram(bincount=100))

plot(x=rand(100), y=rand(100))

plot(x=rand(20), y=rand(20), Geom.point, Geom.line)

plot(x=1:20, y=3.^rand(20),
     Scale.y_sqrt, Geom.point, Geom.smooth,
     Guide.xlabel("This is the X label"),
     Guide.ylabel("This is the y label"),
     Guide.title("This is the title"))

?SVGJS

?Gadfly.plot

using RDatasets

plot(dataset("datasets", "iris"),
    x="SepalLength", y="SepalWidth", Geom.point)

plot(dataset("car", "SLID"),
    x="Wages", color="Language", Geom.histogram)

plot(dataset("mlmRev","Gcsemv"),
    x="Course", color="Gender", Geom.histogram)

dd  =  plot(x =  rand(10),  y = rand(10));
draw(SVG("random-pts.svg",  15cm, 12cm) , dd);

set_default_plot_size(15cm, 9cm);
mlmf = dataset("mlmRev","Gcsemv")
df = mlmf[complete_cases(mlmf), :]
names(df)
plot(df, x="Course", y="Written", color="Gender")

plot((x,y) -> x*exp(-(x-int(x))^3-y^2), -10., 10, -3., 3)

plot([sin, cos], 0, 30)

x = [1:100;];
y1 = 1 - 2*rand(100);
y2 = randn(100);
plot(
 layer(x=x,y=y1,Geom.line,Theme(default_color=color("red"))),
 layer(x=x,y=y2,Geom.line,Theme(default_color=color("blue")))
)

p1 = plot(x=rand(1,1,10), y=rand(1,1,10))
p2 = plot(x=rand(10,1,20), y=rand(10,1,20))
draw(PNG("p1and2.png", 6inch, 6inch), vstack(p1,p2))
p3 = plot(x=rand(20,1,30), y=rand(20,1,30))
p4 = plot(x=rand(30,1,40), y=rand(30,1,40))
draw(PNG("p1to4.png", 6inch, 9inch), vstack(hstack(p1,p2),hstack(p3,p4)))

shapes = Gadfly.compose(Gadfly.context(), fill("cornflowerblue"),
          (Gadfly.context( 0.1, 0.1, 0.15, 0.1 ),  Gadfly.circle()),
          (Gadfly.context( 0.35, 0.06, 0.2, 0.18 ),
          Gadfly.rectangle(), Gadfly.fill("red")),
          (Gadfly.context( 0.6, 0.05, 0.2, 0.2), Gadfly.fill("magenta3"),
          Gadfly.polygon([(1, 1), (0.3, 1), (0.5, 0)]) ));
img = SVG("shapes.svg", 10cm, 8.66cm)
draw(img,shapes)

using Compose
function sierpinski(n)
  if n == 0
    compose(context(), polygon([(1,1), (0,1), (1/2, 0)]));
  else 
    t = sierpinski(n - 1);
    compose( context(), (context( 1/4, 0, 1/2, 1/2), t),
                        (context( 0, 1/2, 1/2, 1/2), t),
                        (context( 1/2, 1/2, 1/2, 1/2), t));
  end
end

cx1 = compose(sierpinski(1), linewidth(0.2mm),
  fill(nothing), stroke("black"));
img = SVG("sierp1.svg", 10cm, 8.66cm); draw(img,cx1)

cx3 = compose(sierpinski(3), linewidth(0.2mm),
  fill(nothing), stroke("black"));
img = SVG("sierp3.svg", 10cm, 8.66cm); draw(img,cx3)

cx5 = compose(sierpinski(5), linewidth(0.2mm),
  fill(nothing), stroke("black"));
img = SVG("sierp5.svg", 10cm, 8.66cm); draw(img,cx5)

plot(x=rand(30), y=rand(30), Stat.step, Geom.line)

using Distributions
plot(x=rand(Normal(), 150), y=rand(Normal(), 150), Stat.qq, Geom.point)
plot(x=rand(Normal(), 150), y=Normal(), Stat.qq, Geom.point)

# Providing a fixed set of ticks
plot(x=rand(20), y=rand(20),
     Stat.xticks(ticks=[0.0, 0.2, 0.8, 1.0]),
     Stat.yticks(ticks=[0.0, 0.1, 0.9, 1.0]),
     Geom.point)

plot(dataset("lattice", "singer"),
    x="VoicePart", y="Height", Geom.boxplot)

plot(dataset("ggplot2", "diamonds"),
    x="Price", color="Cut", Geom.density)

plot(dataset("HistData", "ChestSizes"),
    x="Chest", y="Count", Geom.bar)

# Explicitly setting the number of bins
plot(dataset("car", "UN"), x="GDP", y="InfantMortality",
     Scale.x_log10, Scale.y_log10,
     Geom.histogram2d(xbincount=20, ybincount=20))

x_data = 0.0:0.1:3.0
y_data = x_data.^2 + rand(length(x_data))
plot(x=x_data, y=y_data,
    Geom.point,
    Geom.smooth(method=:loess,smoothing=0.9))

set_default_plot_size(20cm, 7.5cm)
plot(dataset("datasets", "OrchardSprays"),
     xgroup="Treatment", x="ColPos", y="RowPos", color="Decrease",
     Geom.subplot_grid(Geom.point))

using DataFrames
set_default_plot_size(8cm, 12cm)
widedf = DataFrame(x = [1:10], var1 = [1:10], var2 = [1:10].^2)
longdf = stack(widedf, [:var1, :var2])
plot(longdf, ygroup="variable", x="x", y="value",
    Geom.subplot_grid(Geom.point, free_y_axis=true))

set_default_plot_size(15cm, 10cm)

plot(dataset("datasets", "iris"), x="SepalLength", y="SepalWidth",
     yintercept=[2.5, 4.0], Geom.point, Geom.hline,
     xintercept=[5.0, 7.0], Geom.point, Geom.vline)

xs = 0:0.1:20

df_cos = DataFrame(
    x=xs,
    y=cos(xs),
    ymin=cos(xs) .- 0.5,
    ymax=cos(xs) .+ 0.5,
    f="cos"
)

df_sin = DataFrame(
    x=xs,
    y=sin(xs),
    ymin=sin(xs) .- 0.5,
    ymax=sin(xs) .+ 0.5,
    f="sin"
)

df = vcat(df_cos, df_sin)
p = plot(df, x=:x, y=:y, ymin=:ymin, ymax=:ymax, color=:f, Geom.line, Geom.ribbon)

plot(dataset("lattice", "singer"),
    x="VoicePart", y="Height", Geom.violin)

# Binding categorial data to x
plot(dataset("lattice", "singer"),
    x="VoicePart", y="Height", Geom.beeswarm)

# Transform both dimensions
plot(x=rand(100), y=rand(100),
    Scale.x_log, Scale.y_log)

# Treat numerical y data as categories
plot(x=rand(20), y=rand(20),
    Scale.x_discrete)

using Colors
x = repeat([1:10], inner=[10])
y = repeat([1:10], outer=[10])
plot(x=x,y=y,color=x+y, Geom.rectbin,
     Scale.ContinuousColorScale(Scale.lab_gradient(colorant"green",
                                                   colorant"white",
                                                   colorant"red")))

plot(sin, 0, 2pi,
     Guide.annotation(
       compose(context(), circle([pi/2, 3*pi/2], [1.0, -1.0], [2mm]), fill(nothing),
       stroke(colorant"orange"))))


