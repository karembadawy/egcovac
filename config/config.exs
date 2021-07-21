# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :egcovac,
  ecto_repos: [Egcovac.Repo]

# Configures the endpoint
config :egcovac, EgcovacWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xSiuChOjbnbd5BZsAuSdQANNsl88jSVe9IH/DeeoWDkQK6tvFuLV8Aa5VYkItV8F",
  render_errors: [view: EgcovacWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Egcovac.PubSub,
  live_view: [signing_salt: "d/PRpNOw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
