defmodule Egcovac.UsersTest do
  use Egcovac.DataCase

  alias Egcovac.Users

  describe "users" do
    alias Egcovac.Users.User

    @valid_attrs %{birth_date: ~D[2010-04-17], category: "some category", city: "some city", email: "some email", gender: "some gender", job: "some job", name: "some name", nid: "some nid", phone: "some phone", weight_index: 120.5}
    @update_attrs %{birth_date: ~D[2011-05-18], category: "some updated category", city: "some updated city", email: "some updated email", gender: "some updated gender", job: "some updated job", name: "some updated name", nid: "some updated nid", phone: "some updated phone", weight_index: 456.7}
    @invalid_attrs %{birth_date: nil, category: nil, city: nil, email: nil, gender: nil, job: nil, name: nil, nid: nil, phone: nil, weight_index: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.birth_date == ~D[2010-04-17]
      assert user.category == "some category"
      assert user.city == "some city"
      assert user.email == "some email"
      assert user.gender == "some gender"
      assert user.job == "some job"
      assert user.name == "some name"
      assert user.nid == "some nid"
      assert user.phone == "some phone"
      assert user.weight_index == 120.5
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.birth_date == ~D[2011-05-18]
      assert user.category == "some updated category"
      assert user.city == "some updated city"
      assert user.email == "some updated email"
      assert user.gender == "some updated gender"
      assert user.job == "some updated job"
      assert user.name == "some updated name"
      assert user.nid == "some updated nid"
      assert user.phone == "some updated phone"
      assert user.weight_index == 456.7
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
