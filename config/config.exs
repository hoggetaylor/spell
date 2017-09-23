# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :spell,
  ecto_repos: [Spell.Repo]

# Configures the endpoint
config :spell, SpellWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q6OZQO+AVw5dlb8ABSTrmWtI3d3Kz0wyoPyhA9ScCm0/oyturOZs4g730jVdACTi",
  render_errors: [view: SpellWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Spell.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]}
  ]
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
