defmodule Egcovac.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :registration_number, :string
      add :appointment, :utc_datetime_usec
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:requests, [:user_id])
  end
end
