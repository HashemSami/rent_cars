defmodule RentCarsWeb.Api.SessionControllerTest do
  use RentCarsWeb.ConnCase

  alias RentCars.Shared.Tokenr

  test "throws an error when the user is not authenticated", %{conn: conn} do
    conn = post(conn, ~p"/api/sessions/me?#{%{token: "wrong token"}}")

    assert json_response(conn, 401)["error"] == "Unauthenticated/Invalid Token"
  end

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

    test "forgot password", %{conn: conn, user: user} do
      conn = post(conn, ~p"/api/sessions/forgot_password?#{%{email: user.email}}")

      assert response(conn, 204) == ""
    end

    test "forgot password with error", %{conn: conn} do
      conn = post(conn, ~p"/api/sessions/forgot_password?#{%{email: "lkjhasdf@hadh.com"}}")

      assert json_response(conn, 400)["message"] == "user does not exist"
    end

    test "reset password", %{conn: conn, user: user} do
      token = Tokenr.generate_forgot_email_token(user)

      conn =
        post(
          conn,
          ~p"/api/sessions/reset_password?#{%{token: token, user: %{password: "newPassword", password_confirmation: "newPassword"}}}"
        )

      assert json_response(conn, 200)
    end

    test "Throw error when try to reset password", %{conn: conn} do
      conn =
        post(
          conn,
          ~p"/api/sessions/reset_password?#{%{token: "wrong token", user: %{password: "newPassword", password_confirmation: "newPassword"}}}"
        )

      assert json_response(conn, 400)["message"] == "Invalid token"
    end
  end
end
