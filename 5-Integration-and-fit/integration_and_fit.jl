using QuadGK
using Plots
using Optim

the_real_function(t) = sin(t)
ts = collect(0:0.3:4*π)
mock_vals= map(t->the_real_function(t)+0.6*randn(), ts)
real_vals= map(t->the_real_function(t), ts)
plot(ts,real_vals)
scatter!(ts,mock_vals)

# We are not guessing the function to fit the data, 
# but a function that after we integrate over, 
# we will fit the data.
guess_function(t,a,b) = a*cos(b*t)

function f(t,a,b) 
   res = quadgk(t′->guess_function(t′,a,b),0,t)[1]
   res[1]
end 

# we define the goodness of the fit
χ2(a,b) = sum([(f(ti,a,b)-mock_vals[i])^2 for (i,ti) in enumerate(ts)])

res = optimize(x->χ2(x...),[1.0,1.0])

asol, bsol = Optim.minimizer(res)

ts

# plot solution 
plot(ts,map(t->f(t,asol,bsol),ts), label="best fit") 
# plot accurate solution
plot!(ts,real_vals, label="original function") 
# plot data
scatter!(ts,mock_vals, label="data points") 
