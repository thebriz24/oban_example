defmodule ObanExampleWeb.PageController do
  use ObanExampleWeb, :controller
  alias ObanExample.Feats

  def index(conn, %{"filter" => %{"date" => date}}) do
    with {:ok, parsed} <- Date.from_iso8601(date),
         ranking when not is_nil(ranking) <- Feats.get_daily_ranking_by_date(parsed) do
      superheroes = Feats.all_superheroes()
      superheroes = Feats.preload_superhero_daily_statistics_for_date(superheroes, parsed)
      ordered = order_superheros_according_to_rank(superheroes, ranking.ranked_superhero_ids)
      render(conn, "index.html", superheroes: ordered)
    else
      nil ->
        conn
        |> put_flash(:error, "No rankings found for that date")
        |> render("index.html", superheroes: [])

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid date")
        |> render("index.html", superheroes: [])
    end
  end

  def index(conn, _params) do
    render(conn, "index.html", superheroes: [])
  end

  defp order_superheros_according_to_rank(superheroes, ordered_ids) do
    ordered_ids
    |> Enum.reverse()
    |> Enum.reduce([], fn id, acc ->
      superhero =
        Enum.find(superheroes, fn superhero ->
          superhero.id == id
        end)

      [superhero | acc]
    end)
  end
end
