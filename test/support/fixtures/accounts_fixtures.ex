defmodule RentCars.AccountsFixtures do
  alias RentCars.Accounts

  def user_attrs(attrs \\ %{}) do
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
    |> Enum.into(user_attrs)

  end

  def user_fixture(attrs \\ %{}) do



    {:ok, user} =
      attrs
      |> user_attrs()
      |> Accounts.create_user()

    user
  end
end
