defmodule RentCars.Cars do
  alias RentCars.Repo
  alias __MODULE__.Car

  def get_car!(id), do: Repo.get(Car, id)

  def create(attrs) do
    %Car{}
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
