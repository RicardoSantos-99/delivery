defmodule Delivery.ViaCep.Client do
  use Tesla

  alias Tesla.Env
  alias Delivery.Error

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  def get_cep_info(cep) do
    "#{cep}/json/"
    |> get()
    |> handle_get()
  end

  def handle_get({:ok, %Env{status: 200, body: %{"error" => true}}}) do
    {:error, Error.build(:not_found, "CEP not found!")}
  end

  def handle_get({:ok, %Env{status: 200, body: body}}), do: {:ok, body}

  def handle_get({:ok, %Env{status: 400, body: _body}}) do
    {:error, Error.build(:bad_request, "Invalid CEP!")}
  end

  def handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
