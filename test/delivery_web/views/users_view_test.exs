defmodule DeliveryWeb.UsersViewTest do
  use DeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Delivery.Factory

  alias DeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "falsetoken"

    response = render(UsersView, "create.json", user: user, token: token)

    assert %{
             message: "User created!",
             token: "falsetoken",
             user: %Delivery.User{
               address: "123 Main St",
               age: 27,
               cep: "12312312",
               cpf: "12312312312",
               email: "john@doe",
               id: "1ba8cfa7-c584-489a-8dd0-c16740d7f9ae",
               inserted_at: nil,
               name: "John",
               password: "123123123",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
