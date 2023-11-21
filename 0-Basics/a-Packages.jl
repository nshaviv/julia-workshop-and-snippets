# Julia has a very powerful package manager, which allows you to install and manage packages.

# To install a package (which you do once) you use the Pkg.add() function:
using Pkg
Pkg.add("Plots")   

# To use a package or several packages (which you do every time you start Julia)
# you use the `using` command (as many times as you want)

using Plots, LinearAlgebra

# To update a package you use the Pkg.update() function.
Pkg.update("Plots")

# To remove a package you use the Pkg.rm() function.
Pkg.rm("Plots")

# To see what packages you have installed you use the Pkg.status() function.
Pkg.status()

# You can also access the package manager through the REPL by typing ] at the prompt.
# (@v1.9) pkg> add Plots
# (@v1.9) pkg> update Plots
# (@v1.9) pkg> rm Plots
# (@v1.9) pkg> status
# and then press backspace to return to the REPL.

#= 
You can also press ; and type shell commands. 
julia> 
shell> echo 'hello world in the shell'
hello world in the shell
shell> 
julia> 
type *backspace* to return to the julia prompt.
=# 