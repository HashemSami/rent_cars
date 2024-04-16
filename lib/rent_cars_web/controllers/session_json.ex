defmodule RentCarsWeb.SessionJSON do
  alias RentCarsWeb.UserJSON

  def render("session.json", %{session: session}) do
    %{
      data: %{
        token: session.token,
        user: UserJSON.render("show_user.json", %{user: session.user})
      }
    }
  end

  # def render("show.json", %{session: session}) do
  #   %{
  #     data: UserJson.render("show_user.json", %{user: session.user})
  #   }
  # end
end
