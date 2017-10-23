defmodule Chat.Main do

  def main() do
    room = [self()]
    server_pid = spawn(fn ->
      Chat.Server.loop(room)
    end)

    spawn(fn() ->
      Chat.Client.join(server_pid)
      Chat.Client.say(server_pid, "Hi!")
      Chat.Client.leave(server_pid)
    end)

    spawn(fn() ->
      Chat.Client.join(server_pid)
      Chat.Client.say(server_pid, "What's up?")
      Chat.Client.leave(server_pid)
    end)

    Enum.each((1..6), fn(_) ->
      Chat.Client.flush(server_pid)
    end)
  end
end
