using Turing
using Distributions

physical_model(x, A, ϕ) = A .* sin.(2π .* x .+ ϕ)

function generate_data(x, A_true, ϕ_true, σ_noise)
    y_clean = physical_model(x, A_true, ϕ_true)
    return y_clean .+ σ_noise .* randn(length(x))
end

# ---- Now we define the model with Turing ----

@model function sine_model(x, y_obs, σ_noise)
    # Priors (same as your log_prior)
    A ~ Uniform(0, 10)
    ϕ ~ Uniform(-π, π)

    # Mean model
    μ = physical_model(x, A, ϕ)

    # Likelihood (same as log_likelihood)
    y_obs ~ MvNormal(μ, σ_noise^2 * I)
end

# --- Run the MCMC sampling ---

using Random
Random.seed!(1234)

# True parameters
A_true = 5.0
ϕ_true = 0.5
σ_noise = 0.5

# Data
x = range(0, 1, length=100)
y_obs = generate_data(x, A_true, ϕ_true, σ_noise)

# Build model
model = sine_model(x, y_obs, σ_noise)

# Sample (NUTS = modern replacement for MH)
chain = sample(
    model,
    NUTS(0.65),
    10_000 ÷ 3;
    discard_initial = 500
)


using MCMCChains # Package for handling MCMC chains
using StatsPlots

Plots.plot(chain)

A_samples = Array(chain[:A])
ϕ_samples = Array(chain[:ϕ])

chain[:A] |> mean |> x->println("A mean: ", x)
chain[:A] |> std |> x->println("ϕ mean: ", x)

p1 = histogram(A_samples, bins=30, xlabel="Amplitude (A)", title="Posterior of A")
p2 = histogram(ϕ_samples, bins=30, xlabel="Phase (ϕ)", title="Posterior of ϕ")
plot(p1, p2, layout=(1,2))

# From StatsPlots, we can also do a density plot directly from the chain
density(chain[:A])

violinplot(chain)

using StatsPlots

corner(
    chain;
    vars = [:A, :ϕ],
    labels = ["Amplitude (A)", "Phase (ϕ)"],
    colormap = :grays,   # MUST be a ColorScheme
)

using CairoMakie
using KernelDensity
using Statistics

A_samples = vec(Array(chain[:A]))
ϕ_samples = vec(Array(chain[:ϕ]))
kde_2d = kde((A_samples, ϕ_samples))

kde_A  = kde(A_samples)
kde_ϕ  = kde(ϕ_samples)
kde_2d = kde((A_samples, ϕ_samples))

x = kde_2d.x
y = kde_2d.y
z = kde_2d.density

fig = Figure(resolution = (600, 600))

# Marginal A (top-left)
ax_A = Axis(
    fig[1, 1],
    xlabel = "Amplitude (A)",
    ylabel = "Density"
)

# Joint (bottom-left)
ax_joint = Axis(
    fig[2, 1],
    xlabel = "Amplitude (A)",
    ylabel = "Phase (ϕ)"
)

# Marginal ϕ (bottom-right, rotated)
ax_ϕ = Axis(
    fig[2, 2],
    xlabel = "Density",
    ylabel = "Phase (ϕ)"
)

# --- Marginals ---
lines!(ax_A, kde_A.x, kde_A.density; linewidth = 2, color = :black)

# ROTATED phase marginal
lines!(ax_ϕ, kde_ϕ.density, kde_ϕ.x; linewidth = 2, color = :black)

# --- Joint scatter ---
Makie.scatter!(
    ax_joint,
    A_samples,
    ϕ_samples;
    markersize = 2,
    color = (:black, 0.15)
)

# --- Joint KDE contours ---
Makie.contour!(
    ax_joint,
    x, y, z;
    levels = 6,
    linewidth = 1.2,
    color = :black
)

Makie.contour!(
    ax_joint,
    x, y, z;
    levels = quantile(z[:], [0.68, 0.95]),
    linestyle = :dash,
    color = :black
)

# --- Cosmetic alignment ---
hidexdecorations!(ax_A, grid = false)
hideydecorations!(ax_ϕ, grid = false)

fig

save("corner_plot.pdf", fig)
save("corner_plot.png", fig)
