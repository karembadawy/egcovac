defmodule Egcovac.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field :appointment, :date
    field :registration_number, :string

    belongs_to :user, Egcovac.Users.User

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:registration_number, :appointment, :user_id])
    |> validate_required([:registration_number])
  end
end
