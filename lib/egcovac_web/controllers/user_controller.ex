defmodule EgcovacWeb.UserController do
  use EgcovacWeb, :controller

  alias Egcovac.Users
  alias Egcovac.Users.User

  alias Egcovac.Requests

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    user_params = weight(user_params)
    case Users.create_user(user_params) do
      {:ok, user} ->
        request = Requests.create_request(%{
          user_id: user.id,
          registration_number: "#{generate_registration_number}#{user.id}"
        })
        conn
        |> put_flash(:info, "Registration created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  def weight(user_params) do
    job_weight = get_job_weight(user_params["job"])
    age_weight = get_age_weight(user_params["birth_date"])
    category_weight = get_category_weight(user_params["category"])
    submit_date_weight = get_submit_date_weight(DateTime.utc_now)
    IO.puts "weight is #{job_weight}"
    IO.puts "Job is #{user_params["job"]}"
    IO.puts "Age is #{age_weight}"
    IO.puts "Category weight is #{category_weight}"
    IO.puts "Submit date weight is #{submit_date_weight}"
    weight = (category_weight * 10000 ) + (age_weight * 1000) + ( job_weight * 100 ) - submit_date_weight
    user_params |> Map.put("weight_index", weight)
  end


  def get_job_weight(job) do

    cond do
     "#{job}" == "engineering" -> 2
     "#{job}" == "education" -> 3
     "#{job}" == "finance" -> 1
     "#{job}" == "industry" -> 1
     "#{job}" == "police" -> 2
     "#{job}" == "tourism" -> 5
     "#{job}" == "other" -> 0
    end
  end

  def get_age_weight(dob) do
    today = Date.utc_today()
    dob = Date.from_iso8601! dob
    today.year - dob.year
  end

  def get_category_weight(category) do
    cond do
     "#{category}" == "medical" -> 10
     "#{category}" == "patients" -> 20
     "#{category}" == "elders" -> 30
     "#{category}" == "other" -> 0
    end
  end

  def get_submit_date_weight(sub_date) do
    trunc(Float.ceil( (DateTime.to_unix(DateTime.from_naive!(sub_date, "Etc/UTC")) / 36000000),0))
  end

  def generate_registration_number do
    s = for _ <- 1..10, into: "", do: <<Enum.random('0123456789')>>
  end
end
