defmodule ObanTest.Seeds do
  @moduledoc false
  alias ObanTest.Feats
  require Logger

  desired_count = 100
  current_count = Enum.count(Feats.all_superheroes())
  needed_count = max(desired_count - current_count, 0)

  Logger.info("Needing #{needed_count} superheroes added to the database.")

  needed_countries = (needed_count / 20) |> trunc() |> max(1)

  countries =
    fn -> Faker.Address.En.country() end |> Stream.repeatedly() |> Enum.take(needed_countries)

  builder = fn ->
    %{
      name: Faker.Superhero.En.name(),
      power: Faker.Superhero.En.power(),
      country: Enum.random(countries)
    }
  end

  {inserted, _} =
    builder |> Stream.repeatedly() |> Enum.take(needed_count) |> Feats.bulk_create_superheroes()

  Logger.info("Inserted #{inserted} superheroes added to the database.")
end
