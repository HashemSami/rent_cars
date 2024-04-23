defmodule RentCarsWeb.Api.Admin.CarController do
  use RentCarsWeb, :controller
  alias RentCars.Cars

  action_fallback RentCarsWeb.FallbackController

  def create(conn, %{"car" => attrs}) do
    # error will be handled by the FallbackController module

    with {:ok, car} <- Cars.create(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/admin/categories/#{car}")
      |> render("show.json", %{car: car})
    end
  end

  def show(conn, params) do
    with car <- Cars.get_car!(params) do
      conn
      # |> put_status(:created)
      |> render("show.json", %{car: car})
    end
  end
end
