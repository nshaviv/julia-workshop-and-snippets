
function estimate_π(n)
    s = 1.0
    for i in 1:n
        s += (isodd(i) ? -1 : 1) / (2i + 1)
    end
    4s
end

@time estimate_π(10^8)

# This actually has to allocate a vector of length n and then sum it. 
estimate_π(n)= 4.0*(1.0+sum([(isodd(i) ? -1 : 1) / (2i + 1) for i ∈ 1:n]))

@time estimate_π(10^8)

# You can actually run the code many times and see the statistics
using BenchmarkTools
@benchmark estimate_π(10^8)

#If you're a real geek, you can see the LLMV code generated:
@code_llvm estimate_π(10^8)

# Or the assembly code:
@code_native estimate_π(10^8)

# You can also do profiling

using Profile

@profile estimate_π(10^8)

Profile.print()

function estimate_π2(n)
    s = 1.0
    @inbounds for i in 1:n
        s += (isodd(i) ? -1 : 1) / (2i + 1)
    end
    4s
end
# You can also use the @inbounds macro to avoid bounds checking

@time estimate_π2(10^8)

function my_func()
    for i=1:10
    A = rand(1000,1000)
    maximum(A)
    A*A'
    inv(A)
    svd(A)
    end
end 
using LinearAlgebra
@profile my_func()

Profile.print()

using Pkg; Pkg.add("ProfileView")
using ProfileView

my_func()
@profile my_func()
ProfileView.view()