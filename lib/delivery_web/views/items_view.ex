defmodule DeliveryWeb.ItemsView do
  use DeliveryWeb, :view

  alias Delivery.Item

  def render("create.json", %{item: %Item{} = item}) do
    %{
      message: "Item created!",
      item: item
    }
  end
end
