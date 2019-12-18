# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :impressioner, ImpressionerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5y0AjaUziGj7jAB72+Ya/tOCici6V0htksxM3FqU1ECaoPxsTq/uUaw/5yTd7pL/",
  render_errors: [view: ImpressionerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Impressioner.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "g58eRAKY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
