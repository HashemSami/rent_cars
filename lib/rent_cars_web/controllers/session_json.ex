defmodule RentCarsWeb.SessionJson do
  alias RentCarsWeb.UserJson

  def render("session.json", %{session: session}) do
    %{
      token: session.token,
      user: UserJson.render("show_user.json", %{user: session.user})
    }
  end

  def render("show.json", %{session: session}) do
    %{
      data: session
    }
  end
end
