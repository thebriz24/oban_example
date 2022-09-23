defmodule ObanTest.DailyRankingProcessor do
  @moduledoc false
  use Oban.Worker, queue: :default
  alias ObanTest.Feats
  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"date_id" => date_id}}) do
    stats = Feats.all_superhero_daily_statistics_for_date(date_id)

    sorted_ids =
      stats
      |> Enum.sort(fn hero1, hero2 -> hero1.people_saved >= hero2.people_saved end)
      |> Enum.map(fn hero -> hero.superhero_id end)

    Feats.create_daily_ranking(%{date_id: date_id, ranked_superhero_ids: sorted_ids})
  end
end
