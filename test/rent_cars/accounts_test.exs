defmodule RentCars.AccountsTest do
  use RentCars.DataCase

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

    test "create_user/1 with duplicated name", %{user_attrs: user_attrs} do
      valid_attrs = user_attrs

      assert {:ok, _user} = Accounts.create_user(valid_attrs)
      assert {:error, changeset} = Accounts.create_user(valid_attrs)
      assert "has already been taken" in errors_on(changeset).drive_license
    end

    test "create_user/1 with invalid email", %{user_attrs: user_attrs} do
      attrs =
        user_attrs
        |> Map.put(:email, "email hash")

      assert {:error, changeset} = Accounts.create_user(attrs)
      assert "please type a valid email" in errors_on(changeset).email
    end

    test "create_user/1 with short password", %{user_attrs: user_attrs} do
      attrs =
        user_attrs
        |> Map.put(:password, "hash")

      assert {:error, changeset} = Accounts.create_user(attrs)
      assert "should be at least 6 character(s)" in errors_on(changeset).password
    end

    test "create_user/1 with wrong password confirmation", %{user_attrs: user_attrs} do
      attrs =
        user_attrs
        |> Map.put(:password_confirmation, "hash")

      assert {:error, changeset} = Accounts.create_user(attrs)
      assert "does not match confirmation" in errors_on(changeset).password_confirmation
    end
  end
end
