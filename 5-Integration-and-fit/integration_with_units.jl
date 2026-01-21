using Unitful
using QuadGK
using Unitful: s, m
using BenchmarkTools

v(t) = 3m/s + 2m/s^2 * t + sin(100t/s)m/s

@benchmark x, err = quadgk(v, 0s, 10s)

# Lets strip the units for performance
v_nounits(t) = 3.0 + 2.0 * t + sin(100.0 * t)
@benchmark x, err = quadgk(v_nounits, 0.0, 10.0)
