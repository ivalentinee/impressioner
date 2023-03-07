import Config

config :impressionner, ImpressionnerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "NjDw+leY1rTHBe2x7MHlSlRvsMCeuymTGQKiaoawZmH2bo+r7FZ92mncQNZgrW44",
  server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
