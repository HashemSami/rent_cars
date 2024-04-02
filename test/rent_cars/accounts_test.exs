defmodule RentCars.AccountsTest do
  use RentCars.DataCase

  describe "create users" do
    test "create_user/1 with valid dates" do
      valid_attrs = %{
        first_name: "my first_name"
      }

      assert {:ok, user} = Accounts.create_user(valid_attrs)
      assert user.first_name == valid_attrs.first_name
    end
  end
end
