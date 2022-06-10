defmodule DeliveryWeb.UsersController do
  use DeliveryWeb, :controller

  alias Delivery.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- Delivery.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
