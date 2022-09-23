defmodule ObanTest.Repo do
  use Ecto.Repo,
    otp_app: :oban_test,
    adapter: Ecto.Adapters.Postgres
end
