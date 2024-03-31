defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase
  alias RentCarsWeb.Router.Helpers

  test "List all categories", %{conn: conn} do
    conn = get(conn, ~p"/api/categories")

    assert json_response(conn, 200)["data"] == []
  end

  test "Create category when the data is valid", %{conn: conn} do
    attrs = %{description: "category desc", name: "HASH"}
    conn = post(conn, Helpers.api_category_path(conn, :create, category: attrs))
    assert %{"name" => "HASH"} = json_response(conn, 201)["data"]
  end

  test "Create category when the data is invalid", %{conn: conn} do
    attrs = %{description: "category desc"}
    conn = post(conn, Helpers.api_category_path(conn, :create, category: attrs))
    assert %{"name" => ["can't be blank"]} = json_response(conn, 422)["errors"]
  end

  test "Get a category with id", %{conn: conn} do
    attrs = %{description: "category desc", name: "HASH"}

    conn = post(conn, Helpers.api_category_path(conn, :create, category: attrs))
    %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, Helpers.api_category_path(conn, :show, id))
    category = json_response(conn, 200)["data"]
    IO.inspect(category)

    name = String.upcase(attrs.name)
    assert %{"name" => ^name} = json_response(conn, 200)["data"]
  end
end
