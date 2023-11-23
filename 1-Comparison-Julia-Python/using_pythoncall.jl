# There are two packages that can be used to call Python from Julia: PyCall and PythonCall.
# Here is a comparison between PythonCall to PyCall: https://juliapy.github.io/PythonCall.jl/v0.2/pycall/
# One of the main differences is that PyCall returns a julia object while PythonCall returns a Python object.
# Which you will have to convert to Julia. This is done with the pyconvert function.
# Without the automatic conversion there is more flexibility and it is generally faster if the value
# should return back to python (thus avoiding another conversion)

# Here we will use PythonCall. 

# Of course, you need to install the package once
# using Pkg; Pkg.add("PythonCall")

# The easiest way to handle Python and its packages is through a conda installation within the julia environment.
# This can be easily done with the CondaPkg package.
# Pkg.add("CondaPkg")

# Now that the packages are installed, lets add needed packages, e.g., 
using CondaPkg
CondaPkg.add("astropy"; version="", channel="")

using PythonCall
u = pyimport("astropy.units")
c = pyimport("astropy.constants")

vesc2 = c.G*c.M_sun/(c.R_sun)
vesc2.value
pyconvert(Float64, vesc2.value)

np = pyimport("numpy")
# Create a NumPy array
array_py = np.array([1, 2, 3, 4, 5])

# Sum the elements of the array using NumPy
sum_py = np.sum(array_py * c.G.value)

println("Sum of the array elements times G is: ", sum_py)

sum_jl = pyconvert(Float64, sum_py) 
