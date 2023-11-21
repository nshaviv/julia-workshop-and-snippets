# This is an example taken from the Fluid Mechanics course. There are several Laplace solvers out there, 
# So in reality there is no need to reinvent the wheel. Namely, this code is mostly for educational purposes.

using Plots, LaTeXStrings, Plots.PlotMeasures

# Initialize the grid. We start with a simple guess
function initgrid(n::Integer,m::Integer)
   ϕ = ones(n,m) .* 0.5
   imposeboundary!(ϕ)
   return(ϕ)
end

# This is a function to calculate ϕnew for the internal part
function newgrid(ϕold::Array{Float64,2})
  ϕnew = similar(ϕold)
  (n,m) = size(ϕold)
  ϕnew[2:n-1,2:m-1] = (ϕold[1:n-2,2:m-1] + ϕold[3:n,2:m-1]
                    + ϕold[2:n-1,1:m-2] + ϕold[2:n-1,3:m]) ./ 4
  imposeboundary!(ϕnew)
  return ϕnew
end

# This function modifies the cells on the edge to fit the boundaries
# The convention in Julia is that functions named with ! can modify their arguments
# .= broadcasts, i.e., does the operation on each element
function imposeboundary!(ϕ::Array{Float64,2})
   (n,m) = size(ϕ)
   ϕ[1:n,1] .= 1
   ϕ[1:n,m] .= 1
   ϕ[1,1:m] .= 0
   ϕ[n,1:m] .= 0
   ϕ[n÷4:n÷3,2*n÷3:3*m÷4] .= 1.2
   return nothing
end

# calculate one step with over relaxation speedup
function onestep(ϕ::Array{Float64,2},α)
  ϕnew = newgrid(ϕ)
  ϕnew = ϕ + α * (ϕnew - ϕ)
  return ϕnew
end

function laplacesolve(α ; Δmax=0.01)
   ϕ = initgrid(100,100)
   Δ=10.0; iterations=0;
   # loop while Δ is large (also, stop if gets crazy)
   while Δ > Δmax && Δ < 100.0 && iterations < 10000
      ϕnew = onestep(ϕ, iterations < 100 ? 1.0 : α)
      Δ = findmax(abs.(ϕnew-ϕ))[1]
      ϕ=ϕnew
      iterations += 1
   end
   return (ϕ,iterations,Δ)
end

(ϕsol,iters,Δ)=laplacesolve(1.0;Δmax=1e-5)

xrange = LinRange(0,1,100)
yrange = LinRange(0,1,100)
contourf(xrange,yrange,ϕsol',aspectratio=1,legend=:topleft, frame=:box,
    xlims=(0,1),ylims=(0,1), left_margin=30px, levels=0:0.05:1.2,
    bottom_margin=20px, right_margin=20px, xtickfontsize=18,
    ytickfontsize=18, size=(1000,1000), c=:coolwarm)

savefig("Phi2D.pdf")
