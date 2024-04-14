defmodule RentCarsWeb.SessionJson do
  alias RentCarsWeb.UserJson

  def render("session.json", %{session: session}) do
    %{
      data: %{
        token: session.token,
        user: UserJson.render("show_user.json", %{user: session.user})
      }
    }
  end

  # def render("show.json", %{session: session}) do
  #   %{
  #     data: UserJson.render("show_user.json", %{user: session.user})
  #   }
  # end
end
