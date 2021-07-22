defmodule Egcovac.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :birth_date, :date
    field :category, Ecto.Enum, values: [:medical, :elders, :patients, :other]
    field :city, Ecto.Enum, values: [:alexandria, :cairo, :giza, :helwan, :ismailia, :luxor, :new_valley, :north_sinai, :red_sea, :suez]
    field :email, :string
    field :gender, Ecto.Enum, values: [:male, :female]
    field :job, Ecto.Enum, values: [:education, :engineering, :finance, :industry, :police, :tourism, :other]
    field :name, :string
    field :nid, :string
    field :phone, :string
    field :weight_index, :float

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:category, :name, :nid, :birth_date, :gender, :city, :job, :email, :phone, :weight_index])
    |> validate_required([:category, :name, :nid, :birth_date, :gender, :city, :job, :email, :phone])
  end
end
