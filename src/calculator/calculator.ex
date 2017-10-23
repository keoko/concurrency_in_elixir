defmodule Calculator do
  def actor_start(counter) do
    spawn(Calculator, :loop, [counter])
  end

  def inc(pid, number) do
    send pid, {:inc, number}
  end

  def slow_inc(pid, number) do
    send pid, {:slow_inc, number}
  end

  def get(pid) do
    send pid, {:get, self()}
    receive do
      state -> IO.puts("counter is #{state}")
    end
  end

  def stop(pid) do
    send pid, :stop
  end

  def loop(state) do
    receive do
      {:inc, number} ->
        loop(state + number)
      {:dec, number} ->
        loop(state - number)
      {:slow_inc, number} ->
        :timer.sleep(10000)
        loop(state + number)
      {:get, clientPid} ->
        send clientPid, state
        loop(state)
      :stop ->
        IO.puts("stopped")
    end
  end
end
