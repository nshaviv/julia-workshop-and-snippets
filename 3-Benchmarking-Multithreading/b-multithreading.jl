# How many threads are available?
Threads.nthreads()

# this can be changed when running julia 
# julia --threads 17 
# or through an environment variable

# Multi threading can be handled manually, by spawning threads.
# We won't go into it.

# There are also automations. e.g., 

a = zeros(12);
Threads.@threads for i = 1:12
    a[i] = Threads.threadid()
end
a



@time begin
    s = zeros(100);
    for i = 1:100
        a = rand(3000,3000)
        v = rand(3000)
#        r = a*v
#        s[i] = sum(r);
    end
    println(s[1:4])
end

@time begin
    s = zeros(100);
    Threads.@threads for i = 1:100
        a = rand(3000,3000)
        v = rand(3000)
 #       r = a*v
 #       s[i] = sum(r);
    end
    println(s[1:4])
end




