defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories

  action_fallback RentCarsWeb.Api.FallbackController

  def index(conn, _params) do
    conn
    |> json(%{
      data: Categories.list_categories()
    })
  end

  def create(conn, %{"category" => attrs}) do
    with {:ok, category} <- Categories.create_category(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/categories/#{category}")
      |> json(%{
        data: category
      })
    end

    # case Categories.create_category(attrs) do
    #   {:error, _msg} = err ->
    #     conn
    #     |> put_status(:not_found)
    #     |> json(%{
    #       data: err
    #     })

    #   {:ok, category} ->

    # end
  end

  def show(conn, params) do
    with category <- Categories.get_category(params) do
      conn
      # |> put_status(:created)
      |> json(%{
        data: category
      })
    end

    # case Categories.get_category(params) do
    #   nil ->
    #     "error"

    #   category ->
    #     conn
    #     # |> put_status(:created)
    #     |> json(%{
    #       data: category
    #     })
    # end
  end
end
