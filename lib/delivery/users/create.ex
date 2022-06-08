defmodule Delivery.Users.Create do
  alias Delivery.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
