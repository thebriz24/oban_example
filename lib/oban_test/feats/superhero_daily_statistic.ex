defmodule ObanTest.Feats.SuperheroDailyStatistics do
  @moduledoc false

  use Ecto.Schema
  alias Ecto.Changeset
  alias ObanTest.Feats.{Date, Superhero}

  @required ~w(superhero_id date_id people_saved crises_averted)a

  schema "superhero_daily_statistics" do
    field(:people_saved, :integer)
    field(:crises_averted, :integer)
    belongs_to(:superhero, Superhero)
    belongs_to(:date, Date)

    timestamps()
  end

  def changeset(data \\ %__MODULE__{}, attrs) do
    data
    |> Changeset.cast(attrs, @required)
    |> Changeset.validate_required(@required)
    |> Changeset.unique_constraint([:date_id, :superhero_id])
  end
end
