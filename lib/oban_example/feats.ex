defmodule ObanExample.Feats do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias __MODULE__.{DailyRanking, Superhero, SuperheroDailyStatistics}
  alias __MODULE__.Date, as: FeatsDate
  alias Ecto.Changeset
  alias ObanExample.Repo

  def change_daily_ranking(%DailyRanking{} = data), do: DailyRanking.changeset(data, %{})
  def change_daily_ranking(attrs), do: DailyRanking.changeset(attrs)
  def change_daily_ranking(data, attrs), do: DailyRanking.changeset(data, attrs)
  def create_daily_ranking(%Changeset{} = changeset), do: Repo.insert(changeset)
  def create_daily_ranking(attrs), do: attrs |> change_daily_ranking() |> create_daily_ranking()
  def get_daily_ranking(id), do: Repo.get(DailyRanking, id)

  def get_daily_ranking_by_date(date) do
    Repo.one(
      from r in DailyRanking,
        join: d in assoc(r, :date),
        where: d.date == ^date
    )
  end

  def get_daily_ranking_by_date_id(date_id), do: Repo.get_by(DailyRanking, date_id: date_id)

  def all_daily_rankings, do: Repo.all(DailyRanking)
  def update_daily_ranking(%Changeset{} = changeset), do: Repo.update(changeset)

  def update_daily_ranking(%DailyRanking{} = data, attrs),
    do: data |> change_daily_ranking(attrs) |> update_daily_ranking()

  def update_daily_ranking(id, attrs),
    do: id |> get_daily_ranking() |> update_daily_ranking(attrs)

  def delete_daily_ranking(%Changeset{} = changeset), do: Repo.delete(changeset)
  def delete_daily_ranking(%DailyRanking{} = data), do: Repo.delete(data)
  def delete_daily_ranking(id), do: Repo.delete_all(from r in DailyRanking, where: r.id == ^id)

  def change_date(%FeatsDate{} = data), do: FeatsDate.changeset(data, %{})
  def change_date(attrs), do: FeatsDate.changeset(attrs)
  def change_date(data, attrs), do: FeatsDate.changeset(data, attrs)
  def create_todays_date(), do: create_date(%{date: Date.utc_today()})
  def create_date(%Changeset{} = changeset), do: Repo.insert(changeset)
  def create_date(attrs), do: attrs |> change_date() |> create_date()
  def get_date(id), do: Repo.get(FeatsDate, id)
  def get_todays_date(), do: get_date_by_date(Date.utc_today())
  def get_date_by_date(date), do: Repo.one(from d in FeatsDate, where: d.date == ^date)
  def all_dates, do: Repo.all(FeatsDate)
  def update_date(%Changeset{} = changeset), do: Repo.update(changeset)
  def update_date(%FeatsDate{} = data, attrs), do: data |> change_date(attrs) |> update_date()
  def update_date(id, attrs), do: id |> get_date() |> update_date(attrs)
  def delete_date(%Changeset{} = changeset), do: Repo.delete(changeset)
  def delete_date(%FeatsDate{} = data), do: Repo.delete(data)
  def delete_date(id), do: Repo.delete_all(from d in FeatsDate, where: d.id == ^id)

  def change_superhero(%Superhero{} = data), do: Superhero.changeset(data, %{})
  def change_superhero(attrs), do: Superhero.changeset(attrs)
  def change_superhero(data, attrs), do: Superhero.changeset(data, attrs)
  def create_superhero(%Changeset{} = changeset), do: Repo.insert(changeset)
  def create_superhero(attrs), do: attrs |> change_superhero() |> create_superhero()

  def bulk_create_superheroes(attrs),
    do: Repo.insert_all(Superhero, attrs)

  def get_superhero(id), do: Repo.get(Superhero, id)
  def all_superheroes, do: Repo.all(Superhero)
  def update_superhero(%Changeset{} = changeset), do: Repo.update(changeset)

  def update_superhero(%Superhero{} = data, attrs),
    do: data |> change_superhero(attrs) |> update_superhero()

  def update_superhero(id, attrs), do: id |> get_superhero() |> update_superhero(attrs)
  def delete_superhero(%Changeset{} = changeset), do: Repo.delete(changeset)
  def delete_superhero(%Superhero{} = data), do: Repo.delete(data)
  def delete_superhero(id), do: Repo.delete_all(from s in Superhero, where: s.id == ^id)

  def change_superhero_daily_statistics(%SuperheroDailyStatistics{} = data),
    do: SuperheroDailyStatistics.changeset(data, %{})

  def change_superhero_daily_statistics(attrs), do: SuperheroDailyStatistics.changeset(attrs)

  def change_superhero_daily_statistics(data, attrs),
    do: SuperheroDailyStatistics.changeset(data, attrs)

  def create_superhero_daily_statistics(%Changeset{} = changeset), do: Repo.insert(changeset)

  def create_superhero_daily_statistics(attrs),
    do: attrs |> change_superhero_daily_statistics() |> create_superhero_daily_statistics()

  def bulk_create_superhero_daily_statistics(attrs),
    do: Repo.insert_all(SuperheroDailyStatistics, attrs)

  def get_superhero_daily_statistics(id), do: Repo.get(SuperheroDailyStatistics, id)
  def all_superhero_daily_statistics, do: Repo.all(SuperheroDailyStatistics)

  def all_superhero_daily_statistics_for_date(date_id),
    do: Repo.all(from s in SuperheroDailyStatistics, where: s.date_id == ^date_id)

  def preload_superhero_daily_statistics_for_date(superheroes, date) do
    Repo.preload(superheroes,
      superhero_daily_statistics:
        from(s in SuperheroDailyStatistics, join: d in assoc(s, :date), where: d.date == ^date)
    )
  end

  def update_superhero_daily_statistics(%Changeset{} = changeset), do: Repo.update(changeset)

  def update_superhero_daily_statistics(%SuperheroDailyStatistics{} = data, attrs),
    do: data |> change_superhero_daily_statistics(attrs) |> update_superhero_daily_statistics()

  def update_superhero_daily_statistics(id, attrs),
    do: id |> get_superhero_daily_statistics() |> update_superhero_daily_statistics(attrs)

  def delete_superhero_daily_statistics(%Changeset{} = changeset), do: Repo.delete(changeset)
  def delete_superhero_daily_statistics(%SuperheroDailyStatistics{} = data), do: Repo.delete(data)

  def delete_superhero_daily_statistics(id),
    do: Repo.delete_all(from s in SuperheroDailyStatistics, where: s.id == ^id)
end
