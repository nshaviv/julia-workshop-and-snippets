# Another package is Makie: https://docs.makie.org/stable/

# CairoMakie = Nicer but less interactive
# GLMakie = More interactive but less suitable for publication

using CairoMakie

σ=10
x=-10:0.1:10
y=exp.(-x.^2/(2σ)).*sin.(x)
lines(x,y)

# you want to add a line, you need the figure object
lines(x, y)
lines!(x, 0.1*cos.(x))
current_figure()

# having a legend 
lines(x, y, label="Gaussine")
lines!(x, 0.1*cos.(x), label="Cosine")
axislegend()
current_figure()


#########################


x = -5:0.2:5
y = -5:0.2:5
z = -5:0.2:5

ϕ = [exp(-(x^2+y^2+z^2)/(2σ))*sin(x)*cos(y)*sin(z) for x in x, y in y, z in z]

volume(ϕ, algorithm = :mip)

# more examples at: http://juliaplots.org/MakieReferenceImages/gallery/index.html 

