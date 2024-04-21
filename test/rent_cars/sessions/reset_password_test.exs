defmodule RentCars.Sessions.ResetPassword_test do
  use RentCars.DataCase

  alias RentCars.Sessions.ResetPassword
  alias RentCars.Shared.Tokenr
  import RentCars.AccountsFixtures

  test "reset user password" do
    user = user_fixture()

    token = Tokenr.generate_forgot_email_token(user)

    params = %{
      "token" => token,
      "user" => %{"password" => "new_shiny_pass", "password_confirmation" => "new_shiny_pass"}
    }

    assert {:ok, user_return} = ResetPassword.execute(params)
    assert user.email == user_return.email
  end

  test "throws error when token is invalid" do
    params = %{
      "token" => "wrong token",
      "user" => %{}
    }

    assert {:error, message} = ResetPassword.execute(params)
    assert "Invalid token" == message
  end
end
