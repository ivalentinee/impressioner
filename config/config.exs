import Config

config :impressionner, ImpressionnerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: ImpressionnerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Impressionner.PubSub,
  live_view: [signing_salt: "0vA7jDCw"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :esbuild,
  version: "0.14.41",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

import_config "#{config_env()}.exs"
