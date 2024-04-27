defmodule RentCarsWeb.Api.Admin.CategoryJSON do
  alias RentCars.Categories.Category

  def index(%{categories: categories}) do
    %{data: for(category <- categories, do: data(category))}
  end

  @doc """
  Renders a single specification.
  """
  def show(%{category: category}) do
    %{data: data(category)}
  end

  defp data(%Category{} = category) do
    %{
      id: category.id,
      name: category.name,
      description: category.description
    }
  end
end
