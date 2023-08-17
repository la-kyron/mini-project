defmodule TodoApi.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :hashed_password, :string
    has_one :user, TodoApi.Users.User
    has_many :todo, TodoApi.Todos.Todo
    #add optional: true if not required
    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :hashed_password])
    |> validate_required([:email, :hashed_password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Invalid email format!")
    |> unique_constraint(:email)
    |> hash_password()
  end

  def todo_changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :hashed_password])
    |> validate_required([:email, :hashed_password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Invalid email format!")
    |> unique_constraint(:email)
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{hashed_password: hashed_password}} = changeset) do
    change(changeset, hashed_password: Bcrypt.hash_pwd_salt(hashed_password))
  end

  defp hash_password(changeset) do
    changeset
  end
end
