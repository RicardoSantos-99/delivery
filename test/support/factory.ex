defmodule Delivery.Factory do
  use ExMachina

  def user_params_factory do
    %{
      age: 27,
      address: "123 Main St",
      cep: "12312312",
      cpf: "12312312312",
      email: "john@doe",
      password: "123123123",
      name: "John"
    }
  end
end
