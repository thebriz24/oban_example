defmodule ObanTest.Feats.Date do
  @moduledoc false
  use Ecto.Schema
  alias Ecto.Changeset
  alias ObanTest.Feats.{DailyRanking, SuperheroDailyStatistics}

  @required ~w(date)a

  schema "dates" do
    field(:date, :date)
    has_many(:superhero_daily_statistics, SuperheroDailyStatistics)
    has_one(:daily_ranking, DailyRanking)
    timestamps()
  end

  def changeset(data \\ %__MODULE__{}, attrs) do
    data
    |> Changeset.cast(attrs, @required)
    |> Changeset.validate_required(@required)
    |> Changeset.unique_constraint([:date])
  end
end
