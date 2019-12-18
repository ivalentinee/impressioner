use Mix.Config

config :impressioner, ImpressionerWeb.Endpoint,
  url: [host: "localhost", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info
