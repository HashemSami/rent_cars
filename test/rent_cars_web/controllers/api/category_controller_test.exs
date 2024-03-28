defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase

  test "List all categories", %{conn: conn} do
    conn = get(conn, "/api/categories")

    assert json_response(conn, 200)["data"] == [
             %{
               "description" => "pumpkin 123",
               "id" => "123123",
               "name" => "SPORT"
             }
           ]
  end
end
