use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fiberFinder, FiberFinder.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :fiberFinder, FiberFinder.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATABASE_POSTGRESQL_USERNAME") || "postgres",
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || "postgres",
  database: "fiberfinder_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
