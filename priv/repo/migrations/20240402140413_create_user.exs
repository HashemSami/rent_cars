defmodule RentCars.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE roles AS ENUM ('USER', 'ADMIN')"
    drop_quey = "DROP TYPE roles"

    execute create_query, drop_quey

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :user_name, :string
      add :password_hash, :string
      add :email, :string
      add :drive_license, :string
      add :role, :roles, default: "USER", null: false

      timestamps()
    end

    create unique_index(:users, [:drive_license], name: :users_drive_license_index)
    create unique_index(:users, [:email], name: :users_email_index)
    create unique_index(:users, [:user_name], name: :users_user_name_index)
  end
end
