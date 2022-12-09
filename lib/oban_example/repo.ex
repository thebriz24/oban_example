defmodule ObanExample.Repo do
  use Ecto.Repo,
    otp_app: :oban_example,
    adapter: Ecto.Adapters.Postgres
end
