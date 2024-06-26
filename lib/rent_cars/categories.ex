defmodule RentCars.Categories do
  alias __MODULE__.Category
  alias RentCars.Repo

  defstruct name: ""

  def list_categories() do
    Repo.all(Category)
  end

  def create_category(attrs) do
    attrs
    |> Category.changeset()
    |> Repo.insert()
  end

  def get_category!(%{"id" => id}) do
    Repo.get!(Category, id)
  end

  def update_category(category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  def delete_category(category) do
    Repo.delete(category)
  end
end
