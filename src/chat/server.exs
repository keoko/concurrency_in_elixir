defmodule Chat.Server do
  def loop(room) do
    receive do
      {pid, :join} ->
        notify_all(room, self(), "some user with pid #{inspect pid} joined")
        send(self(), :ok)
        loop([pid | room])

      {pid, {:say, message}} ->
        notify_all(room, pid, "#{inspect pid}: #{message}")
        send(pid, {self(), :ok})
        loop(room)

      {pid, :leave} ->
        send(pid, {self(), :ok})
        new_room = List.delete(room, pid)
        notify_all(new_room, self(), "User with pid #{inspect pid} left")
        loop(new_room)
    end
  end

  defp notify_all(room, sender, message) do
    Enum.each(room, fn pid ->
      if pid != sender do
        send(pid, {self(), {:message, message}})
      end
    end)
  end
end
