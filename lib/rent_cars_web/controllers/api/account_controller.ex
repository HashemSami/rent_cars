defmodule RentCarsWeb.Api.AccountController do
  use RentCarsWeb, :controller
  alias RentCars.Accounts

  action_fallback RentCarsWeb.Api.FallbackController

  def create(conn, %{"user" => attrs}) do
    # error will be handled by the FallbackController module
    with {:ok, user} <- Accounts.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/accounts/#{user}")
      |> json(%{
        data: user
      })
    end
  end

  def show(conn, %{"id" => id}) do
    with account <- Accounts.get_user!(id) do
      conn
      # |> put_status(:created)
      |> json(%{
        data: account
      })
    end
  end
end
