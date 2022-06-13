defmodule DeliveryWeb.FallbackController do
  use DeliveryWeb, :controller

  alias Delivery.Error
  alias DeliveryWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
