defmodule DeliveryWeb.OrdersController do
  use DeliveryWeb, :controller

  alias Delivery.Order
  alias DeliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Order{} = order} <- Delivery.create_order(params) do
      conn
      |> put_status(:created)
      |> render("create.json", order: order)
    end
  end
end
