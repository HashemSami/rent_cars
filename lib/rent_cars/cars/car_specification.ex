defmodule RentCars.Cars.CarSpecification do
  alias RentCars.Specifications.Specification
  alias RentCars.Cars.Car
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "car_specifications" do
    belongs_to :car, Car
    belongs_to :specification, Specification

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(car_specification, attrs) do
    car_specification
    |> cast(attrs, [])
    |> validate_required([])
  end
end
