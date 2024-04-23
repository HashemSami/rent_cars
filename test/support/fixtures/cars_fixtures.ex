defmodule RentCars.CarsFixtures do
  alias RentCars.Cars
  import RentCars.CategoriesFixtures

  def car_attrs(attrs \\ %{}) do
    category = category_fixture()

    car_attrs =
      %{
        name: "Lancer",
        description: "good car",
        brand: "Mitsubishi",
        daily_rate: 100,
        license_plate: "asdf #{:rand.uniform(10000)}",
        fine_amount: 30,
        category_id: category.id,
        specifications: [
          %{
            name: "wheels",
            description: "wheels description"
          },
          %{
            name: "windows",
            description: "windows description"
          }
        ]
      }

    Enum.into(attrs, car_attrs)
  end

  def car_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> car_attrs()
      |> Cars.create()

    user
  end
end
