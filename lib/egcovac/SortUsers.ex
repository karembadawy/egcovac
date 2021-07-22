defmodule Egcovac.SortUsers do
  use Task  

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
    # Call API & Persist
    IO.puts "To the moon!"
  end
end
