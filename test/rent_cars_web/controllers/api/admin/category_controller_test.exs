defmodule RentCarsWeb.Api.Admin.CategoryControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CategoriesFixtures

  test "throw error when try listing categories without permission", %{conn: conn} do
    conn = get(conn, ~p"/api/admin/categories")

    assert json_response(conn, 401)["error"] == "User does not have this permission"
  end

  describe "categories admin tests" do
    setup :include_admin_token

    test "List all categories", %{conn: conn} do
      conn = get(conn, ~p"/api/admin/categories")

      assert json_response(conn, 200)["data"] == []
    end

    test "Create category when the data is valid", %{conn: conn} do
      attrs = %{description: "category desc", name: "HASH"}
      conn = post(conn, ~p"/api/admin/categories?#{%{category: attrs}}")

      assert %{"name" => "HASH"} = json_response(conn, 201)["data"]
    end

    test "Create category when the data is invalid", %{conn: conn} do
      attrs = %{description: "category desc"}
      conn = post(conn, ~p"/api/admin/categories?#{%{category: attrs}}")
      assert %{"name" => ["can't be blank"]} = json_response(conn, 422)["errors"]
    end

    test "Get a category with id", %{conn: conn} do
      attrs = %{description: "category desc", name: "HASH"}

      conn = post(conn, ~p"/api/admin/categories?#{%{category: attrs}}")

      %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/admin/categories/#{id}")

      # category = json_response(conn, 200)["data"]
      # IO.inspect(category)

      name = String.upcase(attrs.name)
      assert %{"name" => ^name} = json_response(conn, 200)["data"]
    end
  end

  describe "update category" do
    setup [:create_category, :include_admin_token]

    test "update category with valid data", %{conn: conn, category: category} do
      name = String.upcase("update category name")

      conn =
        put(
          conn,
          ~p"/api/admin/categories/#{category.id}?#{%{attrs: %{name: name}}}"
        )

      assert %{"id" => id} = json_response(conn, 200)["data"]

      # getting the data from the database
      conn = get(conn, ~p"/api/admin/categories/#{id}")
      assert %{"name" => ^name} = json_response(conn, 200)["data"]
    end
  end

  describe "delete category" do
    setup [:create_category, :include_admin_token]

    test "delete category with valid data", %{conn: conn, category: category} do
      conn =
        delete(
          conn,
          ~p"/api/admin/categories/#{category.id}"
        )

      assert json_response(conn, 204)

      # test if the response is not found
      assert_error_sent 404, fn -> get(conn, ~p"/api/admin/categories/#{category.id}") end
    end
  end

  defp create_category(_) do
    category = category_fixture()
    %{category: category}
  end
end
