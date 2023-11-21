# This is an example taken from the Fluid Mechanics course. There are several Laplace solvers out there, 
# So in reality there is no need to reinvent the wheel. Namely, this code is mostly for educational purposes.

# We're solving the problem Δϕ=S on the interval (0,1) with
# S = -1 between 0.25 and 0.50
# ϕ = 0 at x=0 (constant boundary)
# dϕ/dx = 2 at x=1 (constraint on the derivative)

# Import package to plot and to add LaTeX strings to it
using Plots, LaTeXStrings, Plots.PlotMeasures

#In the first installation, I had a problem with the LaTeXStrings package, so I added this line
#ENV["PATH"] = (ENV["PATH"]*":/opt/local/bin:/Library/TeX/texbin");
#Later it wasn't necessary anymore, so it was commented out.

N = 4000;
Δx = 1 / N;
dϕdx1 = -0.25;
ϕ0 = 0;
S0 = -1;
# Generate the source vector. ÷ is the integer division.
# .= is "broadcast" i.e., operate on each element seperately.
# Note that we solve ϕ[i-1]-2ϕ[i]+ϕ[i+1] = Δx^2 S[i]
# The source should be normalized S*width = 1; width = 0.2
S = zeros(N)
S[4*N÷10:6*N÷10] .= -Δx^2 / 0.2
# Generate the Laplace operator
A = zeros(N, N)
# Loop over main part
for i = 2:N-1
   A[i, i-1] = 1
   A[i, i] = -2
   A[i, i+1] = 1
end
# Now insert the values of A at the boundaries.
# Because ϕ is fixed at 0, we don't solve for it.
# The equation is ϕ[0]-2ϕ[1]+ϕ[2] = Δx^2 S[i]
# but write is as -2ϕ[1]+ϕ[2] = Δx^2 S[i] + ϕ0
A[1, 1] = -2;
A[1, 2] = 1;
S[1] = S[1] + ϕ0;
# At i=N we have to impose the derivative constraint
# ϕ[N] = ϕ[N-1] + Δx * dϕdx + S[N] → ϕ[N] - ϕ[N-1] = Δx * dϕdx + S[N]
A[N, N] = 1;
A[N, N-1] = -1;
S[N] = S[N] + Δx * dϕdx1;
# invert the matrix and solve for ϕ.
Ainv = inv(A)
ϕ = Ainv * S
#now plot the solution and the source function
x = [1:N] .* Δx
plot(x, ϕ)
plot!(legend=false, size=(1000, 700), frame=:box, xtickfontsize=18, ytickfontsize=18,
   xlabel=L"x", ylabel=L"\phi", guidefont=font(24), left_margin=30px, bottom_margin=30px,
   aspect_ratio=:equal)
savefig("1D-Laplace-solution.pdf")
