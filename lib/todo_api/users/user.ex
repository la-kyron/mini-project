defmodule TodoApi.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :full_name, :string
    field :gender, :string
    belongs_to :account, TodoApi.Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:full_name, :gender, :account_id])
    |> validate_required([:full_name, :gender, :account_id])
  end
end
