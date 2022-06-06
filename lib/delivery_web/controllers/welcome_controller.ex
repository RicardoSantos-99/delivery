defmodule DeliveryWeb.WelcomeController do
  use DeliveryWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json("Welcome to the Delivery Web!")
  end
end
