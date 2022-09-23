import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :oban_test, ObanTest.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "oban_test_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :oban_test, ObanTestWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "H7Xde9CGLCvwXygCCam+S2yl+2rzJT4Dxs5ZcAYWDRmQWI57SnDWy+s3PFhPp9RF",
  server: false

# In test we don't send emails.
config :oban_test, ObanTest.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :oban_test, Oban, testing: :inline
