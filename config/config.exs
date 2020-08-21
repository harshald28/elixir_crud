# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :discuss_new,
  ecto_repos: [DiscussNew.Repo]

# Configures the endpoint
config :discuss_new, DiscussNewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZD+pKPg79qa+JdwYUWNj48ThoI9c3LMpObnyh3YDopSRKKY0QOFsNGLdrZIkB2Ov",
  render_errors: [view: DiscussNewWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DiscussNew.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user:email"]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "ec64faafa1860211e5be",
  client_secret: "1e03b3314992f28dadf2867d4a59e02e01e24020"
