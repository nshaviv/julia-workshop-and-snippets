# Arrays 

a = Int[]       # We can define a new empty array of Integers
push!(a, 3, 4)  # We can push elements
append!(a, [3, 4]) # Append adds the vector elements
push!(a, [3, 4])   # push wants to add the whole vector, but it cannot because a is a vector of integers

b = []         # b is a vector of anything
push!(b, 3)
push!(b, [3,4])

# Allocate space in the memory
c = zeros(Float64, 1000, 1000)

# Tuples 
t = (1,2,3)

t[2] 

t[2] = 3 # Tuples are not mutable
# So why use them? Because they are faster than arrays

# Named tuple:
nt = (x=0.3, y = 0.6)
nt.x = 0.6  # Still immutable

# Named tuples are useful when you return several values from a function
function free_fall(h)
    g=9.81
    t = sqrt(2*h/g)
    v = g*t
    return (v=v, t=t)
end 

res = free_fall(10)
println("The velocity is $(res.v) and the time is $(res.t)")    

# You can define your own mutable structure:
mutable struct coor2D
    x::Float64
    y::Float64
    coor2D() = new(0.0,0.0)  # This is optional, to define a default value
end

nt=coor2D(0.3,0.4)
nt.x = 0.5
nt.y = 0.6

# a new coor2D with the default values
nt=coor2D()

# You can define operations, such as +, -, *, /, etc. for your own structures
# Be defualt basic operations are not defined for your own structures, you have to expose them.
import Base: +, -, *, /, ^, ==
# Now we can add our definitions, for example:
+(a::coor2D, b::coor2D) = coor2D(a.x+b.x, a.y+b.y)
-(a::coor2D, b::coor2D) = coor2D(a.x-b.x, a.y-b.y)
*(a::coor2D, b::coor2D) = coor2D(a.x*b.x, a.y*b.y)
/(a::coor2D, b::coor2D) = coor2D(a.x/b.x, a.y/b.y)
^(a::coor2D, b::coor2D) = coor2D(a.x^b.x, a.y^b.y)
==(a::coor2D, b::coor2D) = a.x == b.x && a.y == b.y

# or even use your own symbols: 
# See this list of precedence of operators 
# https://github.com/JuliaLang/julia/blob/master/src/julia-parser.scm
# and see here how to enter using latex command: https://docs.julialang.org/en/v1/manual/unicode-input/ 

# \ocirc for ⊗

⊗(a::coor2D, b::coor2D) = a.x*b.y -a.y*b.x

nt1 = coor2D(0.3,0.4)
nt2 = coor2D(0.5,0.6)

nt1 ⊗ nt2
