# See https://discourse.julialang.org/t/seven-lines-of-julia-examples-sought/50416/65?page=3 

using ForwardDiff, LinearAlgebra
using GLMakie

#scatter(rand(50,3))

const FDd = ForwardDiff.derivative

M(u,v) = ((r + v/2*cos(u/2))*cos(u), (r + v/2*cos(u/2))*sin(u), v/2*sin(u/2))
∂M∂u(u,v) = [FDd(u->M(u,v)[1],u), FDd(u->M(u,v)[2],u), FDd(u->M(u,v)[3],u)]
∂M∂v(u,v) = [FDd(v->M(u,v)[1],v), FDd(v->M(u,v)[2],v), FDd(v->M(u,v)[3],v)]

r = 1.0; w = 0.5; m = 90; clr = (:cyan,:red,:cyan,:red,:cyan)
u = range(0, 8π, length = 4m); v = range(-w, w, length = 3)

N = [ -cross(∂M∂u(ui, 0.0), ∂M∂v(ui, 0.0))[j] for ui in u, j in 1:3 ]
N = N ./ sqrt.(sum(abs2,N,dims=2));  N = vec.(Point3f.(N[:,1],N[:,2],N[:,3]))
xs, ys, zs = [[p[i] for p in M.(u, v')] for i in 1:3]
P0 = vec.(Point3f.(xs[:,2], ys[:,2], zs[:,2]))

M.(u,v')

#Makie.inline!(false)

set_theme!(backgroundcolor = :black)
Makie.surface(xs[1:m+1,:], ys[1:m+1,:], zs[1:m+1,:])
for i in 1:4m
    sleep(0.01); 
    k = 1 + i÷(m+0.5);
    arrows!([P0[i]],[N[i]],lengthscale=0.3,arrowsize=0.05,arrowcolor=clr[k],linecolor=clr[k])
end

current_figure()

Point3f(1,2,3)
