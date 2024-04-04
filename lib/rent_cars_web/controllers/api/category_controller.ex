defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories
  alias RentCarsWeb.CategoryJson

  action_fallback RentCarsWeb.Api.FallbackController

  def index(conn, _params) do
    conn
    |> json(CategoryJson.render("category_list.json", %{list: Categories.list_categories()}))
  end

  def create(conn, %{"category" => attrs}) do
    # error will be handled by the FallbackController module
    with {:ok, category} <- Categories.create_category(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/categories/#{category}")
      |> json(CategoryJson.render("show_category.json", %{category: category}))
    end
  end

  def show(conn, params) do
    with category <- Categories.get_category!(params) do
      conn
      # |> put_status(:created)
      |> json(CategoryJson.render("show_category.json", %{category: category}))
    end
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Categories.get_category!(%{"id" => id})

    with {:ok, category} <- Categories.update_category(category, category_params) do
      conn
      # |> put_status(:updated)
      |> json(CategoryJson.render("show_category.json", %{category: category}))
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Categories.get_category!(%{"id" => id})

    with {:ok, category} <- Categories.delete_category(category) do
      conn
      |> put_status(:no_content)
      |> json(CategoryJson.render("show_category.json", %{category: category}))
    end
  end
end
