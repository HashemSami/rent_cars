defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories

  def index(conn, _params) do
    conn
    |> json(%{
      data: Categories.list_categories()
    })
  end

  def create(conn, %{"category" => attrs}) do
    case Categories.create_category(attrs) do
      {:error, _msg} = err ->
        conn
        |> put_status(:not_found)
        |> json(%{
          data: err
        })

      {:ok, category} ->
        conn
        |> put_status(:created)
        |> json(%{
          data: category
        })
    end
  end

  def show(conn, params) do
    case Categories.get_category(params) do
      nil ->
        "error"

      category ->
        conn
        # |> put_status(:created)
        |> json(%{
          data: category
        })
    end
  end
end
