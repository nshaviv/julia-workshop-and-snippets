function f(x,y)
    return √(x^2 + y^2)  # actually you don't need a return statement if it is the last
end

g(x,y) = √(x^2 + y^2)

a = f(1,2) + g(1,2)

function sincos(ϕ)
    return sin(ϕ), cos(ϕ)
end

s, c = sincos(π/3)
s
c

# You can define functions with optional arguments
function my_add(a,b,c=0)
    return a + b + c
end
my_add(1,2)
my_add(1,2,3)

# You can define functions with optional named arguments
function my_add2(a,b; c=0, d=0)
    return a + b + 2*c + d*5
end
my_add2(1,2)
my_add2(1,2;c=3)
my_add2(1,2;c=3,d=9)
my_add2(1,2;d=3)

# You can pass the arguments onwards
function my_add3(a,b; kwargs...)
    println("kwargs is $(kwargs)")   
    println("d argument is:",kwargs[:d])   
    return my_add2(2*a,2*b; kwargs...)
end

my_add3(1,2;c=3,d=9)

v = [1,2]
my_add(v...)    

# Function names with ! are used to indicate that the function modifies its arguments
# It is *customary*, it isn't a language requirement. 

function my_add!(a,b)
    a += b
end

my_add!(v,v)

##### Scope of variables

# Variables defined inside a function are local to that function

function my_function()
    a = 1
    println("a is $(a)")
end

# Variables defined outside a function are global
a=10
my_function()
a 

# If you want to change a global variable inside a function, you need to use the global keyword

function another_function()
    global b = 17
    println("b is $(b)")
end

another_function()
b

#=    <----------------- This is a block comment
Multiple Dispatch

Julia is a multiple dispatch language.
This means that the same functιon name can be used f𝚶r different types of arguments.
=#   
 
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

# Note that different definitions give different speeds


estimate_π(10^8)-π