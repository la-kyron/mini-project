defmodule TodoApi.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :account_id, references(:accounts, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end
  end
end
