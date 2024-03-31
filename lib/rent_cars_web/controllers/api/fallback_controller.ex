defmodule RentCarsWeb.Api.FallbackController do
  use RentCarsWeb, :controller
  alias RentCarsWeb.ErrorJSON

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(ErrorJSON.render("errors.json", %{changeset: changeset}))
  end
end
