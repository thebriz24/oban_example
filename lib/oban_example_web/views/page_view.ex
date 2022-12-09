defmodule ObanExampleWeb.PageView do
  use ObanExampleWeb, :view

  def people_saved(superhero) do
    stat = List.first(superhero.superhero_daily_statistics)
    stat.people_saved
  end
end
