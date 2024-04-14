defmodule RentCars.SessionsTest do
  use RentCars.DataCase

  alias RentCars.Sessions
  import RentCars.AccountsFixtures

  test "return authenticated user" do
    user = user_fixture()
    # the same user's password
    password = "Hash password"

    assert {:ok, user_return, _token} = Sessions.create(user.email, password)
    assert user.email == user_return.email
  end

  test "get user from token" do
    user = user_fixture()
    # the same user's password
    password = "Hash password"

    assert {:ok, _user_return, token} = Sessions.create(user.email, password)
    assert {:ok, user_return} = Sessions.me(token)

    assert user.email == user_return.email
  end

  test "throw error when password is not correct" do
    user = user_fixture()
    # the same user's password
    password = "1233"

    assert {:error, message} = Sessions.create(user.email, password)

    assert "email or password is incorrect" == message
  end

  test "throw error when email is invalid" do
    email = "hashesss@sksj.com"
    # the same user's password
    password = "1233"

    assert {:error, message} = Sessions.create(email, password)
    assert "email or password is incorrect" == message
  end
end
