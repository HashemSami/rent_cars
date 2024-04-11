defmodule RentCars.Sessions.SendForgotToEmail do
  alias RentCars.Repo
  alias RentCars.Accounts.User
  alias RentCars.Shared.Tokenr
  alias RentCars.Mail.ForgotPasswordEmail

  def execute(email) do
    User
    |> Repo.get_by(email: email)
    |> prepare_response()
  end

  defp prepare_response(nil), do: {:error, "user does not exist"}

  defp prepare_response(user) do
    token = Tokenr.generate_auth_token(user)
    ForgotPasswordEmail.deliver(user, token)
    {:ok, user, token}
  end
end
