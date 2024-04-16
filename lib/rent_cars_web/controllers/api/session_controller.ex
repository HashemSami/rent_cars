defmodule RentCarsWeb.Api.SessionController do
  use RentCarsWeb, :controller
  alias RentCars.Sessions
  alias RentCarsWeb.SessionJSON

  action_fallback RentCarsWeb.Api.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    # error will be handled by the FallbackController module
    with {:ok, user, token} <- Sessions.create(email, password) do
      session = %{user: user, token: token}

      conn
      |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/users/#{user}")
      |> json(
        SessionJSON.render("session.json", %{
          session: session
        })
      )
    end
  end

  def me(conn, %{"token" => token}) do
    # error will be handled by the FallbackController module
    with {:ok, user} <- Sessions.me(token) do
      session = %{user: user, token: token}

      conn
      |> json(
        SessionJSON.render("session.json", %{
          session: session
        })
      )
    end
  end

  def reset_password(conn, %{"email" => email}) do
    with {:ok, _user, _token} <- Sessions.reset_password(email) do
      conn
      |> put_status(:no_content)
      |> put_resp_header("content-type", "application/json")
      |> text("")
    end
  end
end
