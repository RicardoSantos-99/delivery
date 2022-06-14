defmodule DeliveryWeb.UsersControllerTest do
  use DeliveryWeb.ConnCase, async: true

  import Delivery.Factory

  describe "create/2" do
    test "when all params are valid, returns a valid user", %{conn: conn} do
      params = %{
        "age" => 27,
        "address" => "123 Main St",
        "cep" => "12312312",
        "cpf" => "12312312312",
        "email" => "john@doe",
        "password" => "123123123",
        "name" => "John"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "123 Main St",
                 "age" => 27,
                 "cpf" => "12312312312",
                 "email" => "john@doe",
                 "id" => _id
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "123123123",
        "name" => "John"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      _expect_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert expect_response = response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "1ba8cfa7-c584-489a-8dd0-c16740d7f9ae"

      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
