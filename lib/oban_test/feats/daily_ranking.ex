defmodule ObanTest.Feats.DailyRanking do
  @moduledoc false

  use Ecto.Schema
  alias Ecto.Changeset
  alias ObanTest.Feats.Date

  @required ~w(ranked_superhero_ids date_id)a

  schema "daily_rankings" do
    field(:ranked_superhero_ids, {:array, :integer})
    belongs_to(:date, Date)

    timestamps()
  end

  def changeset(data \\ %__MODULE__{}, attrs) do
    data
    |> Changeset.cast(attrs, @required)
    |> Changeset.validate_required(@required)
    |> Changeset.unique_constraint([:date_id])
  end
end
