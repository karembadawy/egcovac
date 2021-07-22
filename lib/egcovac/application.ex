defmodule Egcovac.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Egcovac.Repo,
      # Start the Telemetry supervisor
      EgcovacWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Egcovac.PubSub},
      # Start the Endpoint (http/https)
      EgcovacWeb.Endpoint,
      Egcovac.SortUsers
      # Start a worker by calling: Egcovac.Worker.start_link(arg)
      # {Egcovac.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Egcovac.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EgcovacWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
