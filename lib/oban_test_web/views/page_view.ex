defmodule ObanTestWeb.PageView do
  use ObanTestWeb, :view

  def people_saved(superhero) do
    stat = List.first(superhero.superhero_daily_statistics)
    stat.people_saved
  end
end
