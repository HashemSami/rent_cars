defmodule RentCars.Sessions do
  alias RentCars.Repo
  alias RentCars.Shared.Tokenr
  alias RentCars.Accounts.User

  @error_invalid_credentials {:error, "email or password is incorrect"}

  def create(email, password) do
    User
    |> Repo.get_by(email: email)
    |> check_user_exist()
    |> validate_password(password)
  end

  defp check_user_exist(nil), do: @error_invalid_credentials
  defp check_user_exist(user), do: user

  defp validate_password({:error, _} = err, _password), do: err

  defp validate_password(user, password) do
    # verified = Argon2.verify_pass(password, user.pass)
    # verified = password == "Hash password"
    verified = Pbkdf2.verify_pass(password, user.password_hash)

    if verified do
      token = Tokenr.generate_auth_token(user)
      {:ok, user, token}
    else
      @error_invalid_credentials
    end
  end
end
