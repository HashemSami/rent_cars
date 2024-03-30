defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase
  alias RentCarsWeb.Router.Helpers

  test "List all categories", %{conn: conn} do
    conn = get(conn, Helpers.api_category_path(conn, :index))

    assert json_response(conn, 200)["data"] == []
  end

  test "Create category when the data is valid", %{conn: conn} do
    attrs = %{description: "category desc", name: "HASH"}
    conn = post(conn, Helpers.api_category_path(conn, :create, category: attrs))
    inspect(json_response(conn, 201)["data"])
    assert %{"name" => "HASH"} = json_response(conn, 201)["data"]
  end
end
