import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :rent_cars, RentCars.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "rent_cars_test",
  port: String.to_integer("5432"),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  queue_target: 5000,
  queue_interval: 5000

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rent_cars, RentCarsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "K1CC1FhxmSgO0ocCxY2u75blmZhmW4vDn1ReV9BYS0Tilw14iVJH2/S4gLJhQ5P7",
  server: false

# In test we don't send emails.
config :rent_cars, RentCars.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :argon2_elixir,
  t_cost: 1,
  m_cost: 8
