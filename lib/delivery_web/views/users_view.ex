defmodule DeliveryWeb.UsersView do
  use DeliveryWeb, :view

  alias Delivery.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created!",
      user: user
    }
  end
end
