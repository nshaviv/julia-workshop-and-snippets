# Functions can be defined with function/end statements:

function f(x,y)
    return √(x^2 + y^2)  # actually you don't need a return statement if it is the last
end

# or as oneliner (well, it can spill to more than one line)
g(x,y) = √(x^2 + y^2)

a = f(1,2) + g(1,2)

# Here we are returning a tuple with two values, the sin and the cos of the angle:
function sincos(ϕ)
    return sin(ϕ), cos(ϕ)
end
# \phi<tab> to get ϕ

# We get back to values:
s, c = sincos(π/3)
# We can access each one:
s
c
# We could have also kept the result as a tuple, and then access its fields:
sc = sincos(π/3)
println("The sine is $(sc[1]), and the cosine is $(sc[2])")

# You can define functions with optional arguments
function my_add(a,b,c=0)
    return a + b + c
end
my_add(1,2)
my_add(1,2,3)

# You can define functions with optional named arguments
function my_add2(a,b; c=5, d=0)
    return a + b + 2*c + d*5
end
my_add2(1,2)
my_add2(1,2;c=3)
my_add2(1,2;c=3,d=9)
my_add2(1,2;d=3)
# If the argument does not appear, it gets its default value appearing in the 
# function definition (e.g., c=5 if "c=" does not appear in the call)

# You can pass the arguments onwards
function my_add3(a,b; kwargs...)
    println("kwargs is $(kwargs)")   
    println("d argument is:",kwargs[:d])   
    return my_add2(2*a,2*b; kwargs...)
end

my_add3(1,2;c=3,d=9)

# You can also splatt with ... , which basically says that the components of v are 
# used as the different arguments of the call
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