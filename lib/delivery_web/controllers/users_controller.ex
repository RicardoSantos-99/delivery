defmodule DeliveryWeb.ItemsController do
  use DeliveryWeb, :controller

  alias Delivery.Item
  alias DeliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Item{} = item} <- Delivery.create_item(params) do
      conn
      |> put_status(:created)
      |> render("create.json", item: item)
    end
  end
end
