defmodule Delivery.Factory do
  use ExMachina.Ecto, repo: Delivery.Repo

  alias Delivery.User

  def user_params_factory do
    %{
      "age" => 27,
      "address" => "123 Main St",
      "cep" => "12312312",
      "cpf" => "12312312312",
      "email" => "john@doe",
      "password" => "123123123",
      "name" => "John"
    }
  end

  def user_factory do
    %User{
      age: 27,
      address: "123 Main St",
      cep: "12312312",
      cpf: "12312312312",
      email: "john@doe",
      password: "123123123",
      name: "John",
      id: "1ba8cfa7-c584-489a-8dd0-c16740d7f9ae"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
