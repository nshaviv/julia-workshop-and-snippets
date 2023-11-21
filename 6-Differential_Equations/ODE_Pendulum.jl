using DifferentialEquations, Plots

# Constants for the pendulum (length and gravitational acceleration)
L = 1.0  # length of the pendulum
g = 9.81  # acceleration due to gravity

# Pendulum's equation of motion
function pendulum!(du, u, p, t)
    θ, ω = u  # u[1] = θ (angle), u[2] = ω (angular velocity)
    du[1] = ω
    du[2] = -(g/L) * sin(θ)
end

# Time span for the simulation
tspan = (0.0, 10.0)

# Initial conditions
θ0 = π / 4  # 45 degrees
ω0 = 0      # initial angular velocity

u0 = [θ0, ω0]
prob = ODEProblem(pendulum!, u0, tspan)
sol = solve(prob)

plot(sol, vars=(1), label="θ")
plot!(sol, vars=(2), label="dθ/dt")  
plot!(title = "Pendulum with Initial Angle 45°", xlabel="t", ylabel="θ(t), dθ/dt")
plot!(frame=:box)
