pid = spawn(&Counter.loop/0)
send(pid, {:inc, 5})
send(pid, {:inc, 2})
send(pid, {:inc, 7})
