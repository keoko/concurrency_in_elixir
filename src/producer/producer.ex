defmodule Producer do

  def actor_start(consumer) do
    spawn(Producer, :loop, [consumer])
  end

  def produce(pid) do
    send pid, :produce
  end

  def loop(consumer) do
    receive do
      :produce ->
        :timer.sleep(100)
        value = :rand.uniform(100)
        Consumer.consume(consumer, value)
        IO.puts("produced #{value}")
        loop(consumer)
    end
  end
end


defmodule Consumer do

  def actor_start do
    spawn(Consumer, :loop, [[]])
  end

  def consume(pid, value) do
    send pid, {:consume, value}
  end

  def loop(state) do
    receive do
      {:consume, value} ->
        :timer.sleep(200)
        IO.puts "                consumed #{value}"
        loop(state)
    end
  end
end
