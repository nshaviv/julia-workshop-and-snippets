# LoopVectorization is an excellent and aggresive vectorizer
# which can use the vector unit in the CPU etc.

using LoopVectorization

using BenchmarkTools

using LinearAlgebra

function mydot0(a, b)
    s = 0.0
    for i ∈ eachindex(a,b)
        s += a[i]*b[i]
    end
    s
end

function mydot(a, b)
    s = 0.0
    @turbo for i ∈ eachindex(a,b)
        s += a[i]*b[i]
    end
    s
end

a = rand(1000); b=rand(1000);
@btime mydot0($a, $b)
@btime $a ⋅ $b
@btime mydot($a, $b)
