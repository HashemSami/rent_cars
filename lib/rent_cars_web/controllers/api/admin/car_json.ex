defmodule RentCarsWeb.Api.Admin.CarJSON do
  def render("show.json", %{car: car}) do
    %{
      data: car
    }
  end
end
