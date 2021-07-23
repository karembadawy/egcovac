defmodule EgcovacWeb.FollowUpController do
  use EgcovacWeb, :controller

  alias Egcovac.Requests

  def index(conn, %{"registration_number" => registration_number}) when not is_nil(registration_number) do
    request = Requests.get_request!(registration_number)
    render(conn, "show.html", request: request)
  end

  def index(conn, _) do
    render(conn, "new.html", [])
  end
end
