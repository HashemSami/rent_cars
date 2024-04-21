defmodule RentCars.Sessions.ResetPassword do
  alias RentCars.Shared.Tokenr
  alias RentCars.Accounts
  alias RentCars.Repo
  alias RentCars.Accounts.User

  def execute(params) do
    params
    |> Map.get("token")
    |> Tokenr.verify_forgot_email_token()
    |> perform(params)
  end

  defp perform({:error, :expired}, _params), do: {:error, "Invalid token"}

  defp perform({:error, :missing}, _params), do: {:error, "Token is missing"}

  defp perform({:error, _}, _params), do: {:error, "Invalid token"}

  defp perform({:ok, user}, params) do
    User
    |> Repo.get_by(email: user.email)
    |> Accounts.update_user(params)
  end
end
