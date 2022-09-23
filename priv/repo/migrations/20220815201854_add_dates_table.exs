defmodule ObanTest.Repo.Migrations.AddDatesTable do
  use Ecto.Migration

  def change do
    create_if_not_exists table("dates") do
      add :date, :date, null: false
      add :inserted_at, :naive_datetime, null: false, default: fragment("now()")
      add :updated_at, :naive_datetime, null: false, default: fragment("now()")
    end

    create_if_not_exists unique_index("dates", [:date])
  end
end
