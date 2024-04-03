defmodule RentCarsWeb.Api.AccountControllerTest do
  use RentCars.ConnCase

  alias RentCars.Accounts
  import RentCars.AccountsFixtures

  describe "create users" do


    test "create user when the data is valid", %{user_attrs: user_attrs} do
      valid_attrs = user_attrs()

      conn = post(conn, ~p"/api/")

      assert {:ok, user} = Accounts.create_user(valid_attrs)
      assert user.first_name == valid_attrs.first_name
      assert user.email == String.downcase(valid_attrs.email)
    end
  end
end
