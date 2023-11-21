# You need to add the package only once
#using Pkg
#Pkg.add("PythonCall")
#Pkg.add("CondaPkg")

# Needed to import the package once
using CondaPkg
CondaPkg.add("astropy"; version="", channel="")

using PythonCall
#ap = pyimport("astropy")

np = pyimport("numpy")
# Create a NumPy array
array_py = np.array([1, 2, 3, 4, 5])

# Sum the elements of the array using NumPy
sum_py = np.sum(array_py)

println("Sum of the array elements: ", sum_py)

sum_jl = pyconvert(Float64, sum_py) 
