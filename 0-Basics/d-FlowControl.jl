# Here is a standard for loop.
# Inside it we have an if/elseif/else statement:

for a ∈ 1:10
    if a % 3 == 0 
        println()
    elseif a % 2 == 0 
        print("$(a) is even; ")
    else
        print("$(a) is odd; ")
    end
end

# Note that the for loop iterator could have been a=1:10, a in 1:10, a ∈ 1:10 etc. 
# \in<tab> to get the ∈ symbol.

# Ternary operator can replace short if-else statements
# If expr==true ? do this : otherwise do that 
x = rand() > 2 ? 1 : 0

# Break to leave a loop/block
for a = 1:10
    print("a is $(a);")
    if a % 4 == 0 
        break
    end
end

using Pkg; Pkg.add("Primes")
using Primes
# This is again a list comprehension
v = [i for i in 1:100 if isprime(i)]
# Now we iterate over the values in v:
for i in v 
    println(i, " is prime")
end

# For loops can be nested, and succinctly written as well
# like these two loops:
for i in 1:10, j in 1:10
    println("$(i) $(j)")
end

# Suppose we want to loop over two vectors *together*
for (i,j) ∈ zip(1:10, 1:2:20)
    println("$(i) $(j)")
end

# Or get an index and the values 
for (i,p) ∈ zip(1:length(v), v)
    println("$(i) $(p)")
end

# This can also be done with enumerate
for (i,v1) ∈ enumerate(v)
   println("i=",i," v1=",v1)
end

# Also while loops exist
begin
    a = 1
    while a < 10
        println("$(sin(a))")
        a += 1
    end
end

# begin/end block can be used to group statements
z = begin
    x=1
    y=2
    x+y
end
z

# This can be useful if you wish to use list comprehension, but need to execute more than 
# one statement:
[begin a = sqrt(i); a += 1; a end for i=1:10 ]

# short circuit evaluation can be used as very short if statement 
# i.e., just the "true" or "false" side of the ternary operator.

1 > 2 && println("1 is greater than 2")
1 < 2 && println("1 is greater than 2")

1 > 2 || println("1 is not greater than 2")
1 < 2 || println("1 is not greater than 2")

# Why does it work? because Julia calculates the first part of the expression and if it is true, 
# it does not need to calculate the second part to know that the || expression is true.

############ Error catching

an_element = "🍎";
try 
    push!(a_new_vector, an_element) # Adds an_element to a_new_vector at its end.
catch err
    println("Error: ", e)
end 
