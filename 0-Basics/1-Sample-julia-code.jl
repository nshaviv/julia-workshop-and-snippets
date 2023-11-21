using Plots # Load the Plots package

x = 0:0.1:10 # Create a vector of x-values
y = sin.(x); # Cr

plot(x,y,frame=:box,label="sin") # Plot the data    

savefig("My-first-plot.pdf")