defmodule ObanTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ObanTest.Repo,
      # Start the Telemetry supervisor
      ObanTestWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ObanTest.PubSub},
      # Start the Endpoint (http/https)
      ObanTestWeb.Endpoint,
      # Start Oban
      {Oban, Application.fetch_env!(:oban_test, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ObanTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ObanTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
