
 
function a_func(x::Int)
    println("x is an integer")
end

function a_func(x::Float64)
    println("x is a float")
end 

function a_func(x)
    println("x is more generic")
end 


a_func(1)
a_func(1.0)
a_func([1,2,3])


# There is a package called Complex.jl (it is part of the Julia standard library)
# it allows you to do this out of the box
a = 1 + 2im 
b = a^0.25

# There is another package called Rationals.jl (it is part of the Julia standard library as well)

c = 1//2
d = 5//6
c + d^3

# Now, can you do complex rationals? 
# In julia it is almost automatic. It just includes the lines:

'''
//(x::Complex, y::Real) = complex(real(x)//y, imag(x)//y) 
//(x::Number, y::Complex) = x*conj(y)//abs2(y)
'''

# That's it!

c = 1//2 + 2//3im
d = 5//6 + 1//2im
c + d^3

# Another cute example is the ODE with error bars.

# Lets redo a measurement error implementation in Julia

mutable struct Error
    value::Float64
    error::Float64
end

using Plots

xs = [ Error(i, 0.1) for i ∈ 1:10 ]
ys = [ Error(i^2, 0.1+0.15*i) for i ∈ 1:10 ]

# now lets redefine scatter to plot the error bars

function scatter(xs::Vector{Error}, ys::Vector{Error}; kwargs...)
    p = plot(; kwargs...)
    for (x,y) ∈ zip(xs,ys)
        plot!([x.value-x.error,x.value+x.error], [y.value,y.value], label="", color="black")
        plot!([x.value,x.value], [y.value-y.error,y.value+y.error], label="", color="black")
    end
    p
end

scatter(xs, ys, title="Measurement error")

