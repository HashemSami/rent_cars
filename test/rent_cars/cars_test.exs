defmodule RentCars.CarsTest do
  alias RentCars.Cars
  use RentCars.DataCase
  import RentCars.CarsFixtures
  import RentCars.CategoriesFixtures

  test "create a car with valid data" do
    category = category_fixture()

    payload = %{
      name: "Lancer",
      description: "good car",
      brand: "Mitsubishi",
      daily_rate: 100,
      license_plate: "asdf 123",
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

    assert {:ok, car} = Cars.create(payload)

    # IO.inspect(car)

    assert car.name == payload.name
    assert car.license_plate == String.upcase(payload.license_plate)

    Enum.each(car.specifications, fn specification ->
      assert specification.name in Enum.map(payload.specifications, & &1.name)
      assert specification.description in Enum.map(payload.specifications, & &1.description)
    end)
  end

  test "update a car with success" do
    car = car_fixture()

    payload = %{
      name: "Lancer 2023"
    }

    assert {:ok, car_updated} = Cars.update(car, payload)
    assert car_updated.name == payload.name
  end

  test "throw error when updating the license plate" do
    car = car_fixture()

    payload = %{
      license_plate: "update license_plate"
    }

    assert {:error, changeset} = Cars.update(car, payload)
    assert "you can't update license_plate" in errors_on(changeset).license_plate
  end
end
