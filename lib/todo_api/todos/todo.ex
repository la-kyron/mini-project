defmodule TodoApi.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "todos" do
    field :description, :string
    field :title, :string
    belongs_to :account, TodoApi.Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
