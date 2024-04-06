defmodule RentCarsWeb.Api.UserControllerTest do
  use RentCarsWeb.ConnCase

  import RentCars.AccountsFixtures

  describe "create users" do
    test "create user when the data is valid", %{conn: conn} do
      attrs = user_attrs()

      conn = post(conn, ~p"/api/users?#{%{user: attrs}}")

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      user = json_response(conn, 200)["data"]

      email = String.downcase(user["email"])

      IO.inspect(user)

      assert %{
               "id" => ^id,
               "email" => ^email
             } = json_response(conn, 200)["data"]
    end
  end
end
