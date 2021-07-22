defmodule Egcovac.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :category, :string
      add :name, :string
      add :nid, :string
      add :birth_date, :date
      add :gender, :string
      add :city, :string
      add :job, :string
      add :email, :string
      add :phone, :string
      add :weight_index, :float

      timestamps()
    end

  end
end
