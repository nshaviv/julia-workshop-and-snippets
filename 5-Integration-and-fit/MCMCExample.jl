
# Example Monte Carlo Markov Chain (MCMC) implementation in Julia

# Physical Model

function physical_model(x, A, ϕ)
    return y = A * sin.(2π * x .+ ϕ)
end

# Realization of data with noise
function generate_data(x, A_true, ϕ_true, σ_noise)
    y_clean = physical_model(x, A_true, ϕ_true)
    noise = σ_noise * randn(length(x))
    return y_clean + noise
end

# Likelihood function
function log_likelihood(y_obs, y_model, σ_noise)
    residuals = y_obs .- y_model
    return -0.5 * sum((residuals ./ σ_noise).^2)
end

# Prior distributions
function log_prior(A, ϕ)
    if A < 0 || A > 10 || ϕ < -π || ϕ > π
        return -Inf
    end
    return 0.0  # Uniform prior
end

# Posterior function
function log_posterior(y_obs, x, A, ϕ, σ_noise)
    y_model = physical_model(x, A, ϕ)
    return log_likelihood(y_obs, y_model, σ_noise) + log_prior(A, ϕ)
end 

# MCMC Sampling using Metropolis-Hastings
function metropolis_hastings(y_obs, x, σ_noise; 
       n_samples=50000, 
       burn_in=2000
    )
    samples = zeros(n_samples, 2)  # Columns for A and ϕ
    A_current = rand() * 10  # Initial guess for A
    ϕ_current = rand() * 2π - π  # Initial guess
    log_post_current = log_posterior(y_obs, x, A_current, ϕ_current, σ_noise)
    proposal_std = [0.25, 0.05]  # Standard deviations for proposals
    for i in 1:n_samples
        A_proposal = A_current + randn() * proposal_std[1]
        ϕ_proposal = ϕ_current + randn() * proposal_std[2]
        log_post_proposal = log_posterior(y_obs, x, A_proposal, ϕ_proposal, σ_noise)
        log_accept_ratio = log_post_proposal - log_post_current
        if log(rand()) < log_accept_ratio
            A_current = A_proposal
            ϕ_current = ϕ_proposal
            log_post_current = log_post_proposal
        end
        samples[i, :] = [A_current, ϕ_current]
    end
    return samples[burn_in+1:end, :]  # Discard burn-in samples
end

# Example usage
function run_example()
    # True parameters
    A_true = 5.0
    ϕ_true = 0.5
    σ_noise = 0.5
    # Generate synthetic data
    x = range(0, 1, length=100)
    y_obs = generate_data(x, A_true, ϕ_true, σ_noise)
    # Run MCMC
    samples = metropolis_hastings(y_obs, x, σ_noise; n_samples=500000, burn_in=2000)
    return samples
end

# To execute the example, uncomment the following line:
samples = run_example()

using Random
Random.seed!(1234)  # For reproducibility

using Distributions
using StatsPlots
# Plotting the results
A_samples = samples[:, 1]
ϕ_samples = samples[:, 2]
p1 = histogram(A_samples, bins=30, xlabel="Amplitude (A)", ylabel="Frequency", title="Posterior of Amplitude")
p2 = histogram(ϕ_samples, bins=30, xlabel="Phase (ϕ)", ylabel="Frequency", title="Posterior of Phase")
plot(p1, p2, layout=(1,2))

using KernelDensity

kde_A = kde(A_samples)
kde_ϕ = kde(ϕ_samples)

p3 = Plots.plot(kde_A.x, kde_A.density, xlabel="Amplitude (A)", ylabel="Density", title="KDE of Amplitude")
p4 = Plots.plot(kde_ϕ.x, kde_ϕ.density, xlabel="Phase (ϕ)", ylabel="Density", title="KDE of Phase")
plot(p3, p4, layout=(1,2))

# 2D Density Plot
using StatsBase
hist2d = fit(Histogram, (A_samples, ϕ_samples), nbins=(30, 30))
Plots.heatmap(hist2d.edges[1], hist2d.edges[2], hist2d.weights', xlabel="Amplitude (A)", ylabel="Phase (ϕ)", title="2D Histogram of Samples")

# 2D KDE
using KernelDensity
kde_2d = kde((A_samples, ϕ_samples))

x = kde_2d.x
y = kde_2d.y
z = kde_2d.density

Plots.contourf(
    x,
    y,
    z,             
    xlabel = "Amplitude (A)",
    ylabel = "Phase (ϕ)",
    title = "2D KDE of Samples",
    levels = 5
)

