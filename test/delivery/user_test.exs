defmodule Delivery.UserTest do
  use Delivery.DataCase, async: true

  import Delivery.Factory

  alias Delivery.User
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{age: 27}, valid?: true} = response
    end

    test "when updating a changeset, return a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{
        age: 24,
        name: "John Doe"
      }

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{age: 24}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params, %{age: 15, password: "123"})

      response = User.changeset(params)

      expect_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expect_response
    end
  end
end
