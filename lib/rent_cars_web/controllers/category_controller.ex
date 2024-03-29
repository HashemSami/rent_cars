defmodule RentCarsWeb.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories

  def home(conn, _params) do
    render(conn, :category_home, categories: Categories.list_categories())
  end
end
