defmodule ObanTest.Repo.Migrations.AddDailyRankingsTable do
  use Ecto.Migration

  def change do
    create_if_not_exists table("daily_rankings") do
      add :ranked_superhero_ids, {:array, :integer}, null: false
      add :date_id, references("dates", on_delete: :delete_all, on_update: :update_all), null: false
      add :inserted_at, :naive_datetime, null: false, default: fragment("now()")
      add :updated_at, :naive_datetime, null: false, default: fragment("now()")
    end

    create_if_not_exists unique_index("daily_rankings", [:date_id])

  end
end
