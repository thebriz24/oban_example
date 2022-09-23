defmodule ObanTest.Feats.Superhero do
  @moduledoc false

  use Ecto.Schema
  alias Ecto.Changeset
  alias ObanTest.Feats.SuperheroDailyStatistics

  @required ~w(name power country)a

  schema "superheroes" do
    field(:name, :string)
    field(:power, :string)
    field(:country, :string)

    has_many(:superhero_daily_statistics, SuperheroDailyStatistics)

    timestamps()
  end

  def changeset(data \\ %__MODULE__{}, attrs) do
    data
    |> Changeset.cast(attrs, @required)
    |> Changeset.validate_required(@required)
  end
end
