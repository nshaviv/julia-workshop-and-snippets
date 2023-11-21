
function fib(n)
    if n <= 1 return(n) end
    return(fib(n - 1) + fib(n - 2))
end 

@time [fib(30) for i=1:50];