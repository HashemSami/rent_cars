defmodule RentCarsWeb.Api.Admin.CarControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CarsFixtures
  import RentCars.CategoriesFixtures

  describe "create cars" do
    setup :include_admin_token

    test "create cars when data is valid", %{conn: conn} do
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

      conn = post(conn, ~p"/api/admin/cars?#{%{payload: payload}}")
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/admin/cars/#{id}")
      name = payload.name
      assert %{"name" => ^name} = json_response(conn, 200)["data"]
    end
  end
end
