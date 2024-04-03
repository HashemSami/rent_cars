defmodule RentCarsWeb.Api.AccountControllerTest do
  use RentCars.ConnCase

  alias RentCars.Accounts

  describe "create users" do
    setup do
      user_attrs = %{
        first_name: "Hash first_name",
        last_name: "Hash last_name",
        user_name: "Hash user_name",
        password: "Hash password",
        password_confirmation: "Hash password",
        password_hash: "Hash password_hash",
        email: "Email@hash",
        drive_license: "Hash drive_license"
      }

      %{user_attrs: user_attrs}
    end

    test "create_user/1 with valid dates", %{user_attrs: user_attrs} do
      valid_attrs = user_attrs

      assert {:ok, user} = Accounts.create_user(valid_attrs)
      assert user.first_name == valid_attrs.first_name
      assert user.email == String.downcase(valid_attrs.email)
    end
  end
end
