defmodule RentCars.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w/role/a
  @required_fields ~w/first_name last_name user_name password password_confirmation email drive_license/a

  @json_fields ~w/first_name last_name user_name email drive_license/a

  @role_values ~w/USER ADMIN/a
  @derive {Jason.Encoder, only: @json_fields}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :user_name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :drive_license, :string
    field :role, Ecto.Enum, values: @role_values, default: :USER

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint([:drive_license],
      name: :users_drive_license_index
    )
    |> unique_constraint([:email],
      name: :users_email_index
    )
    |> unique_constraint([:user_name],
      name: :users_user_name_index
    )
    |> validate_format(:email, ~r/@/, message: "please type a valid email")
    |> update_change(:email, &String.downcase/1)
    |> validate_length(:password, min: 6, max: 50)
    |> validate_confirmation(:password)
    # |> update_change(:role, &String.upcase/1)
    |> hash_password()
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def update_user(user, params) do
    changeset(user, params)
  end

  defp hash_password(%{valid?: true, changes: %{password: password}} = changeset) do
    # change(changeset, password_hash: "Argon2.add_hash(#{password})")
    change(changeset, password_hash: Pbkdf2.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end
