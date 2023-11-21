using Plots

σ = 10
x = -10:0.1:10
y = exp.(-x.^2/(2σ)).*sin.(x) 
# You can also use the macro @. to broadcast the operations
@. y = exp(-x^2/(2σ))*sin(x)

# basic plot
plot(x,y, label="Gaussine")
# add a curve
plot!(x,0.1*cos.(x), label="Cosine")

plot!(title = "The Gaussine", xlabel="x", ylabel="y", 
      legend=:topleft, frame=:box, xlims=(-10,10), ylims=(-1,1))

using Plots.PlotMeasures

plot!(bottom_margin=18px, right_margin=20px, left_margin=20px, 
      xguidefontsize=18, yguidefontsize=18, size=(500,700))

savefig("output/gaussine.png")
savefig("output/gaussine.svg")
savefig("output/gaussine.pdf")

using LaTeXStrings

plot!(xlabel=L"x", ylabel=L"exp(-x^2/2\sigma)", titlefont="Times", 
      legend=:topleft, frame=:box, xlims=(-10,10), ylims=(-1,1))

# 2D plots

x = -10:0.1:10
y = -8:0.1:8
ϕ = [exp(-(x^2+y^2)/(2σ))*sin(x)*cos(y) for x in x, y in y]

# This is a fast way to plot a 2D array: 
# Note that in order to have the correct orientation, we need to transpose the array
heatmap(ϕ')

#We can also do a contour plot

contour(x,y,ϕ', title = "The 2D Gausscosine")

# or filled
contourf(x,y,ϕ', title = "The 2D Gausscosine")
plot!(xlabel=L"x", ylabel=L"y", titlefont="Times", right_margin=20px)

savefig("output/gausscosine.pdf")

# Many more options are available. See the documentation for Plots.jl
# https://docs.juliaplots.org/stable/ 


# Changing backend

# The default is gr() that makes nice vector plots, but they are not interactive.
# If you want interactive plots, you can use plotly() 

plotly()
contourf(x,y,ϕ', title = "The 2D Gausscosine")
plot!(xlabel=L"x", ylabel=L"y", titlefont="Times New Roman", right_margin=20px)

# To get Latex strings in plotly you need MathJax installed (e.g., can be done in Jypyter)

ϕ = 0:0.1:6π
x = @. cos(ϕ)
y = @. sin(ϕ)
z = @. ϕ/6π
plot(x,y,z, frame=:box)
