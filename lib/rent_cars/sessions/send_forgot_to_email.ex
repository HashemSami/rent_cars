defmodule RentCars.Sessions.SendForgotToEmail do
  alias RentCars.Repo
  alias RentCars.Accounts.User
  alias RentCars.Shared.Tokenr
  alias RentCars.Mail.ForgotPasswordEmail

  def execute(email) do
    User
    |> Repo.get_by(email: email)
    |> remove_important_fields()
    |> prepare_response()
  end

  defp remove_important_fields(nil) do
    nil
  end

  defp remove_important_fields(user) do
    %{
      first_name: user.first_name,
      last_name: user.last_name,
      user_name: user.user_name,
      email: user.email,
      drive_license: user.drive_license
    }
  end

  defp prepare_response(nil), do: {:error, "user does not exist"}

  defp prepare_response(user) do
    token = Tokenr.generate_forgot_email_token(user)
    Task.async(fn -> ForgotPasswordEmail.deliver(user, token) end)
    {:ok, user, token}
  end
end
