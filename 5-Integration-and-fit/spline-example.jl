using CubicSplines
using Plots

datax = [0,1,2.5,5,9,13]
datay = [1,2,4,4,3,2]

scatter(datax, datay)

the_spline = CubicSpline(datax, datay);

# calculate the spline at a given point (e.g. at x=10)
the_spline[10]

# or, cacculate the spline on a vector points all at once
xspline = LinRange(minimum(datax), maximum(datax), 100)
yspline = the_spline[xspline]
plot!(xspline,yspline)