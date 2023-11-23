# From: https://discourse.julialang.org/t/collecting-all-output-from-shell-commands/15592/5 

function execute(cmd::Cmd)
    out = Pipe()
    err = Pipe()
  
    process = run(pipeline(ignorestatus(cmd), stdout=out, stderr=err))
    close(out.in)
    close(err.in)
    stdout = @async String(read(out))
    stderr = @async String(read(err))
    (
      stdout = String(read(out)), 
      stderr = String(read(err)),  
      code = process.exitcode
    )
  end

  result = execute(`ls -l`)

  println(result.stdout)