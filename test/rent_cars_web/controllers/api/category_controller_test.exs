defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase
  alias RentCarsWeb.Router.Helpers

  test "List all categories", %{conn: conn} do
    conn = get(conn, Helpers.api_category_path(conn, :index))

    assert json_response(conn, 200)["data"] == [
             %{
               "description" => "pumpkin 123",
               "id" => "123123",
               "name" => "SPORT"
             }
           ]
  end
end
