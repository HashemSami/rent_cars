defmodule RentCarsWeb.UserJSON do
  def render("show_user.json", %{user: user}) do
    %{
      data: %{
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        user_name: user.user_name,
        email: user.email,
        drive_license: user.drive_license,
        role: user.role
      }
    }
  end
end
