defmodule RentCarsWeb.Api.UserController do
  use RentCarsWeb, :controller
  alias RentCars.Accounts
  alias RentCarsWeb.UserJSON

  action_fallback RentCarsWeb.Api.FallbackController

  def create(conn, %{"user" => attrs}) do
    # error will be handled by the FallbackController module
    with {:ok, user} <- Accounts.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> json(
        UserJSON.render("show_user.json", %{
          user: user
        })
      )
    end
  end

  def show(conn, %{"id" => id}) do
    with user <- Accounts.get_user!(id) do
      conn
      # |> put_status(:created)
      |> json(
        UserJSON.render("show_user.json", %{
          user: user
        })
      )
    end
  end
end
