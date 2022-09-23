defmodule ObanTest.StatisticsGenerator do
  @moduledoc false
  use Oban.Worker, queue: :default
  alias ObanTest.{DailyRankingProcessor, Feats}

  @impl Oban.Worker

  def perform(%Oban.Job{args: %{"date" => date}}) do
    parsed = Date.from_iso8601!(date)
    do_for_date(parsed)
  end

  def perform(%Oban.Job{}) do
    do_for_date(Date.utc_today())
  end

  defp do_for_date(date) do
    created = get_or_create_date(date)
    superheros = Feats.all_superheroes()
    statistics = Enum.map(superheros, &build_statistics(&1, created))

    try do
      Feats.bulk_create_superhero_daily_statistics(statistics)
      %{date_id: created.id} |> DailyRankingProcessor.new() |> Oban.insert()
      {:ok, statistics}
    rescue
      Postgrex.Error ->
        {:error, "statistics already found for this superhero for this day"}
    end
  end

  defp get_or_create_date(date) do
    with nil <- Feats.get_date_by_date(date),
         {:ok, created} <- Feats.create_date(%{date: date}) do
      created
    else
      {:error, _changeset} -> raise "Couldn't create date"
      found -> found
    end
  end

  defp build_statistics(superhero, date) do
    %{
      superhero_id: superhero.id,
      date_id: date.id,
      people_saved: trunc(:rand.uniform() * 100),
      crises_averted: trunc(:rand.uniform() * 3)
    }
  end
end
