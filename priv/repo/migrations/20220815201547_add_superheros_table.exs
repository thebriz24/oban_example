defmodule ObanExample.Repo.Migrations.AddSuperheroesTable do
  use Ecto.Migration

  def change do
    create_if_not_exists table("superheroes") do
      add :name, :string, null: false
      add :power, :string, null: false
      add :country, :string, null: false
      add :inserted_at, :naive_datetime, null: false, default: fragment("now()")
      add :updated_at, :naive_datetime, null: false, default: fragment("now()")
    end

    create_if_not_exists unique_index("superheroes", [:country, :name])
  end
end
