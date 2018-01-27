# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :impressioner, ImpressionerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U6b/CrYuz/gOy4VlChcrZHYt8/bcWZhZDCGWC4RYpYSIXwhBEM6kGLbitb7X8/2s",
  render_errors: [view: ImpressionerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Impressioner.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
