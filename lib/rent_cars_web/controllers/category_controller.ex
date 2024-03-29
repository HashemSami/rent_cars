defmodule RentCarsWeb.CategoryController do
  use RentCarsWeb, :controller

  def home(conn, _params) do
    categories = [
      %{
        "description" => "pumpkin 123",
        "id" => "123123",
        "name" => "SPORT"
      }
    ]

    render(conn, :category_home, categories: categories)
  end
end
