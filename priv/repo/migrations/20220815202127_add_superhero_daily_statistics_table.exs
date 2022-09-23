defmodule ObanTest.Repo.Migrations.AddSuperheroDailyStatisticsTable do
  use Ecto.Migration

  def change do
    create_if_not_exists table("superhero_daily_statistics") do
      add :superhero_id, references("superheroes", on_delete: :delete_all, on_update: :update_all), null: false
      add :date_id, references("dates", on_delete: :delete_all, on_update: :update_all), null: false
      add :people_saved, :integer, null: false, default: 0
      add :crises_averted, :integer, null: false, default: 0
      add :inserted_at, :naive_datetime, null: false, default: fragment("now()")
      add :updated_at, :naive_datetime, null: false, default: fragment("now()")
    end

    create_if_not_exists unique_index("superhero_daily_statistics", [:date_id, :superhero_id])
  end
end
