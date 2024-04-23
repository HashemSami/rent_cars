defmodule RentCarsWeb.Api.Admin.CategoryJSON do
  def render("category_list.json", %{list: list}) do
    %{
      data: list
    }
  end

  def render("show_category.json", %{category: category}) do
    %{
      data: category
    }
  end
end
