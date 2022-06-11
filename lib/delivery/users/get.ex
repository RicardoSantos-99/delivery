defmodule Delivery.Users.Get do
  alias Delivery.{Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, result: "User not found"}}
      user -> {:ok, user}
    end
  end
end
