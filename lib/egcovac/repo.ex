defmodule Egcovac.Repo do
  use Ecto.Repo,
    otp_app: :egcovac,
    adapter: Ecto.Adapters.Postgres
end
