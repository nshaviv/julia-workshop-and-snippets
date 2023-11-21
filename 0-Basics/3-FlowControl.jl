for a = 1:10
    if a % 3 == 0 
        println()
    elseif a % 2 == 0 
        print("$(a) is even; ")
    else
        print("$(a) is odd; ")
    end
end

# ternary operator can replace short if-else statements
x = rand() > 2 ? 1 : 0

# break to leave a loop
for a = 1:10
    print("a is $(a); ")
    if a % 4 == 0 
        break
    end
end

using Pkg; Pkg.add("Primes")
v = [i for i in 1:100 if isprime(i)]
for i in v 
    println(i, " is prime")
end

for i in 1:10, j in 1:10
    println("$(i) $(j)")
end

for (i,j) ∈ zip(1:10, 1:2:20)
    println("$(i) $(j)")
end

for (i,p) ∈ zip(1:length(v), v)
    println("$(i) $(p)")
end

# Also while loops can be used
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

[begin a = sqrt(i); a += 1; a end for i=1:10 ]

## short circuit evaluation

1 > 2 && println("1 is greater than 2")
1 < 2 && println("1 is greater than 2")

1 > 2 || println("1 is not greater than 2")
1 < 2 || println("1 is not greater than 2")

# Why does it work? because Julia calculates the first part of the expression and if it is true, 
# it does not need to calculate the second part to know that the || expression is true.

############ Error catching

an_element = "🍎";
try 
    push!(a_new_vector, an_element)
catch err
    println("Error: ", e)
end 
