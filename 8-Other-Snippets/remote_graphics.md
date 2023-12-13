There are several options to work remotely. One is to use the SSH plugin on VSCode. Another is to simply run julia in a terminal command line. However, what happens if you want to see graphics?

You can use the SixelTerm.jl package together with an advanced Terminal program, just as iTerm2 on MacOS (it is better than the supplied terminal app in many ways).

You can use Plots or CairoMakie as the plotting package. 

With Plots + GR as the backend:

```julia
ENV["GKSwstype"] = "nul"  # Needed for windowless plotting with GR()
using Plots, SixelTerm
plot(sin.(0:0.1:10), background_color=:black, legend=:none)
```

while with CairoMakie you don't need the ENV variable:

```julia
using CairoMakie, SixelTerm
plot(sin.(0:0.1:10))
```

![Alt text](<remote_graphics.png>)