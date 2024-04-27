defmodule RentCarsWeb.Api.Admin.CarController do
  use RentCarsWeb, :controller
  alias RentCars.Cars

  action_fallback RentCarsWeb.FallbackController

  def create(conn, %{"car" => attrs}) do
    # error will be handled by the FallbackController module
    attrs =
      attrs
      |> Map.update(
        "specifications",
        [],
        &(Enum.sort_by(&1, fn {k, _} -> k end) |> Enum.map(fn {_, v} -> v end))
      )

    with {:ok, car} <- Cars.create(attrs) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/admin/cars/#{car}")
      |> render(:show, car: car)
    end
  end

  def show(conn, %{"id" => id}) do
    with car <- Cars.get_car!(id) do
      conn
      # |> put_status(:created)
      |> render(:show, car: car)
    end
  end

  def update(conn, %{"id" => id, "attrs" => attrs}) do
    car = Cars.get_car!(id)

    with {:ok, car} <- Cars.update(car, attrs) do
      conn
      # |> put_status(:created)
      |> render(:show, car: car)
    end
  end
end
