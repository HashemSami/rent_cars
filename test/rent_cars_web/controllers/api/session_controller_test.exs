defmodule RentCarsWeb.Api.SessionControllerTest do
  use RentCarsWeb.ConnCase

  describe "create users" do
    setup :include_normal_user_token

    test "create user when the data is valid", %{conn: conn, user: user, password: password} do
      conn = post(conn, ~p"/api/sessions?#{%{email: user.email, password: password}}")

      assert json_response(conn, 201)["data"]["user"]["data"]["email"] == user.email
    end

    test "get me", %{conn: conn, user: user, token: token} do
      conn = post(conn, ~p"/api/sessions/me?#{%{token: token}}")

      assert json_response(conn, 200)["data"]["user"]["data"]["email"] == user.email
    end

    test "reset password", %{conn: conn, user: user} do
      conn = post(conn, ~p"/api/sessions/reset_password?#{%{email: user.email}}")

      assert json_response(conn, 201)["data"]["user"]["data"]["email"] == user.email
    end
  end
end
