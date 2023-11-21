using CSV, DataFrames
using Plots
# Let us import the file 

file = joinpath("2-Data-Handling-Plotting","data","HYDRO")

hydro = CSV.read(`head -61 $file`, DataFrame, delim=" ", skipto=2, 
        header = [:r, :v, :err, :vdvdr, :dPdRoρ, :g, :grad, :ge, :Γ, :row], ignorerepeated=true)

# Let us plot the data
plot(log10.(hydro.r), log10.(hydro.v))
