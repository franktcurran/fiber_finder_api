# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :fiberFinder, FiberFinder.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "RU3A9ofXrIc4+yj5316d5PDkHcrhsUBqFJkVp8BQETOVz2puU44gGhYzsvHEZgdI",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: FiberFinder.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :arcgis_geocode,
 client_id: "h0jUaWpYzj2WvKtR",
 client_secret: "d658d00929c74cc2beb089b7c5241a27"
