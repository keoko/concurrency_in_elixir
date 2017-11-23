defmodule Counter do
  def loop(count) do
    receive do
      :inc ->
        count = count + 1
        IO.puts("counter is #{count}")
        loop(count)
    end
  end
end

pid = spawn(Counter, :loop, [0])
