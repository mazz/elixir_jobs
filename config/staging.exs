use Mix.Config

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# ElixirJobsWeb.Endpoint.init/2 when load_from_system_env is
# true. Any dynamic configuration should be done there.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phx.digest task
# which you typically run after static files are built.
config :elixir_jobs, ElixirJobsWeb.Endpoint,
  load_from_system_env: true,
  url: [scheme: "https", host: "staging.elixirjobs.net", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

# Do not print debug messages in production
config :logger, level: :info

# BCrypt configuration
config :bcrypt_elixir, :log_rounds, 10

# Configure your database
config :elixir_jobs, ElixirJobs.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :elixir_jobs, ElixirJobsWeb.Guardian,
  issuer: "ElixirJobs",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_ACCESS_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_ACCESS_CONSUMER_SECRET"),
  access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")

config :nadia, token: {:system, "TELEGRAM_TOKEN", ""}

config :elixir_jobs, ElixirJobsWeb.Mailer,
  adapter: Bamboo.MailgunAdapter,
  api_key: System.get_env("MAILGUN_API_KEY"),
  domain: "elixirjobs.net"

config :elixir_jobs, :default_app_email, "no-reply@staging.elixirjobs.net"
config :elixir_jobs, :analytics_id, ""
config :elixir_jobs, :telegram_channel, "elixir_jobs_st"

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :elixir_jobs, ElixirJobsWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [:inet6,
#               port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
#
#     config :elixir_jobs, ElixirJobsWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :elixir_jobs, ElixirJobsWeb.Endpoint, server: true
#