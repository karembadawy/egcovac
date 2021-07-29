defmodule Egcovac.SortUsers do
  use Task

  alias Egcovac.Requests

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
    requests = Requests.list_user_appointments
    Enum.each(requests, fn r -> IO.puts r.appointment end)
  end
end
