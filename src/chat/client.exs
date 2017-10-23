defmodule Chat.Client do

  def join(server) do
    sync_send(server, :join)
  end

  def say(server, message) do
    sync_send(server, {:say, message})
  end

  def leave(server) do
    sync_send(server, :leave)
  end

  def flush(server) do
    receive do
      {^server, {:message, message}} ->
        IO.puts(message)
    end
  end

  def sync_send(server, message) do
    send(server, {self(), message})
    receive do
      {^server, response} ->
        response
    after
      1000 ->
        IO.puts("Connection to room timed out")
        :timeout
    end
  end
end
