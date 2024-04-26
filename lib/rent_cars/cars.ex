defmodule RentCars.Cars do
  alias RentCars.Repo
  alias __MODULE__.Car

  def get_car!(id),
    do:
      Repo.get(Car, id)
      # |> Repo.preload(:category)
      |> Repo.preload(:specifications)

  def create(attrs) do
    %Car{}
    # |> Repo.preload(:category)
    # |> Repo.preload(:specifications)
    |> Car.changeset(attrs)
    |> Repo.insert()
  end

  def update(carId, attrs) do
    carId
    |> get_car!()
    |> Car.update_changeset(attrs)
    |> Repo.update()
  end
end
