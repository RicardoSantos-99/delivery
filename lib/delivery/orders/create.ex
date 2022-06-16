defmodule Delivery.Orders.Create do
  import Ecto.Query
  alias Delivery.{Error, Repo, Order, Item}

  def call(params) do
    params
    |> fetch_items()
  end

  def fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    Repo.all(query)
  end
end

# params = %{
#   "items" => [
#     %{
#       "id" => "8e87a6e3-a0d8-4933-87bc-b1bdb40ca8a3",
#       "quantity" => 2
#     },
#     %{
#       "id" => "ce070614-3473-4d95-97c9-a024615dffa7",
#       "quantity" => 3
#     }
#   ]
# }
