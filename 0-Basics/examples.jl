using Plots
using LaTeXStrings

ϕ = 0:0.1:10
plot(ϕ, sin.(ϕ), xlabel=L"\phi", ylabel=L"\sin(\phi)", frame=:box, label="sin")

savefig("FirstExample.pdf")

#--------------------
# Estimate π

function estimate_π(n)
    s = 1.0
    for i in 1:n
        s += (isodd(i) ? -1 : 1) / (2i + 1)
    end
    4s
end

@time estimate_π(10^8)

estimate_π(n)= 4.0*(1.0+sum([(isodd(i) ? -1 : 1) / (2i + 1) for i ∈ 1:n]))

@time estimate_π(10^8)

using Measurements

x=1±0.1
y = x

sin(x)*sqrt(y)

sin(x)*sqrt(x)

using Plots

x = [i ± 0.1 for i=1:10]
y = sin.(x)
scatter(x,y,frame=:box,label=:none)
