defmodule DeliveryWeb.UsersController do
  use DeliveryWeb, :controller

  def create(conn, params) do
    Delivery.create_user(params)
  end
end
