defmodule RentCars.Sessions.SendForgotToEmailTest do
  use RentCars.DataCase

  alias RentCars.Sessions.SendForgotToEmail
  import RentCars.AccountsFixtures

  test "send email to reset password" do
    user = user_fixture()

    assert {:ok, user_returned, _token} = SendForgotToEmail.execute(user.email)

    assert user.email == user_returned.email
  end

  test "throw error if user does not exist" do
    assert {:error, message} = SendForgotToEmail.execute("invalid user email example")

    assert "user does not exist" == message
  end
end
