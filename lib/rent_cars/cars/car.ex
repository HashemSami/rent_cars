defmodule RentCars.Cars.Car do
  alias RentCars.Categories.Category
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields ~W/available brand daily_rate description fine_amount
  license_plate name category_id/a

  schema "cars" do
    field :name, :string
    field :description, :string
    field :available, :boolean, default: false
    field :brand, :string
    field :daily_rate, :integer
    field :fine_amount, :integer
    field :license_plate, :string
    belongs_to :category, Category
    # field :category_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> update_change(:license_plate, &String.upcase/1)
    |> unique_constraint(:license_plate)
  end
end
