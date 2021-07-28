defmodule Egcovac.SortUsers do
  use Task

  alias Egcovac.Users
  alias Egcovac.Users.User

  def start_link(_arg) do
    Task.start_link(&poll/0)
  end

  def poll() do
    receive do
    after
      60_000 ->
        get_price()
        poll()
    end
  end

  defp get_price() do
    users = Users.list_user_appointments
    Enum.each(users, fn u -> IO.puts u.request.appointment end)
  end
end
