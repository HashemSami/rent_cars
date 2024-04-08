defmodule RentCarsWeb.Api.SessionController do
  use RentCarsWeb, :controller
  alias RentCars.Sessions
  alias RentCarsWeb.SessionJson

  action_fallback RentCarsWeb.Api.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    # error will be handled by the FallbackController module
    with {:ok, user, token} <- Sessions.create(email, password) do
      session = %{user: user, token: token}

      conn
      |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/users/#{user}")
      |> json(
        SessionJson.render("session.json", %{
          session: session
        })
      )
    end
  end
end
