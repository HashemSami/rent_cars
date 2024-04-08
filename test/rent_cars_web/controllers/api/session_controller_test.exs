defmodule RentCarsWeb.Api.SessionControllerTest do
  use RentCarsWeb.ConnCase

  import RentCars.AccountsFixtures

  describe "create users" do
    test "create user when the data is valid", %{conn: conn} do
      user = user_fixture()

      conn = post(conn, ~p"/api/session?#{%{email: user.email, password: "Hash password"}}")

      assert json_response(conn, 201)["user"]["data"]["email"] == user.email
    end
  end
end
