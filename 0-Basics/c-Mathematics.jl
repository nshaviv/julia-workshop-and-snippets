# No for some math!

a = 1           # a simple assingment statement
b= 2; c=3       # You can write multiple statements in one line
    d = 5 +
      6+ 7      # If a statement doesn't end, it can spill over lines      
x = a+b+sin(c); # You can put a semicolon at the end of a statement to suppress output
y = rand() > 0.5 ? a : b^2  # Ternary operator: If expr==true ? to this : otherwise do that 

# Again, a one line definition of a function 
myfun(x) = sin(x) + cos(x)
s = myfun(x)*sin(x)

# Now lets define a vector
v = [1,2,3]

v * v  # One cannot multiply two column (vertical) vectors 
v' * v # inner product: row vector times column vector
v * v' # outer produc: column vector times row vector

using LinearAlgebra  # dot is defined inside LinearAlgebra package
v ⋅ v   # to get the dot symbol, type \cdot and then <TAB>

# Now we can define a 2x2 matrix. This is a 2D array
# It is spread over 3 lines for clarity. 
a = [2 2 3; 
     4 5 6; 
     7 8 9]
a * v

v = rand(1000)
a = randn(1000,1000);

# We can now solve the linear set of equations a^-1 v = x
# E
@time inv(a)*v

@time a \ v

a = [rand() for i=1:1000, j=1:1000]

vs = ["a", "b", "d"]
v = [s for s in vs ]

a = [1,2,3]

a..b = a+1:b+1

a[0..2]


@time inv(a)*v;
@time a \ v;

a[1:3,:]
a[:,1:3]
a[1:3,1:3]*v[end-2:end]

# List comprehension 

y = [x for x in 1:10 if x % 2 == 0]

# map 

y = map(x -> x^2, 1:10)

# map with two arguments

y = map((x,y) -> x+y, 1:10, 1:10)

# but list comprehension makes a 2D matrix

y = [x*y for x in 1:10, y in 1:10]

# broadcasting: for the function to operate on each element separately

x = 1:2:10
y = sin.(x)

x + x
collect(x + x)

x + 1  # does not work! x is a range (or vector) while 1 is a scalar
x .+ 1
collect(x.+1)

# note however that sin of a square matrix is not the same as the sine of each element
x = [1 1; 2 3]
@time sin.(x)
@time sin(x)

# one can also filter the elements 
filter(x -> x > 0.5, [rand() for i=1:10])

firsts = [findfirst(x -> x > 0.5, [rand() for i=1:10]) for j = 1:1000];

nums = [ length( filter(f->f==i, firsts)) for i=1:10]

using Plots
plot(nums)
plot!(1000 ./ 2 .^ (1:10))

using Pkg; Pkg.add("SpecialFunctions")
using SpecialFunctions
# See https://specialfunctions.juliamath.org/stable/functions_overview/ 

xs = 0:0.1:10
plot(xs,log.(gamma.(xs)))

# sometimes piping looks better
exp(cos(sin(xs[1])))
xs[1] |> sin |> cos |> exp
xs .|> sin .|> cos .|> exp
xs |> (x->sin.(x)) |> (x->cos.(x)) |> (x->exp.(x))

# Integers
10 / 3
10 % 3
10 ÷ 3

# Rational numbers
1//3 + 1//2 
sin(2//3)
(2//3).^3
typeof(10 // 3) 

# Complex numbers
sqrt(-1)
sqrt(-1+0im)
sqrt(im)

# Big numbers
big(12)^100

# Strings
s = "Hello world!"
s[1]
s[1:5]*" to you too!"
# Note that string concatination is with *, not with + as in Python.
# * is more natural to describe a noncommutative operation!
string("a", "b", "c")

# Unicode characters
# type \alpha and then <TAB>
α = 1
# \smiley 
😃 = 5.0
sum([1/😃^α for α ∈ 1:100])
😃^5
"😃"^5
sin(😃)

"This is string interpolation: $(1+2)"

"Another example $(sin(😃))"

a_long_string = """
One dark day in the middle of the night,
Two dead boys got up to fight.
Back to back they faced each other,
Drew their swords and shot each other.
A deaf policeman heard the noise,
He came and shot the two dead boys.
If you don't believe this lie is true,
Ask the blind man, he saw it too.
"""

# Parsing

i = parse(Int, "123")
d = parse(Float64, "123")
f = parse(Float32, "123.5")

s = "These are the numbers $(sin(i)) $(d) $(f)"

using Printf
s = @sprintf("These are the numbers %5i %5.2f %5.2f", i, d, f)
