defmodule Delivery.Orders.Create do
  import Ecto.Query
  alias Delivery.{Error, Repo, Order, Item}

  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  def fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> validade_and_multiply_items(items_ids, items_params)
  end

  defp validade_and_multiply_items(items, items_ids, items_params) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    items_ids
    |> Enum.map(fn id -> {id, Map.get(items_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
    |> multiply_items(items_map, items_params)
  end

  defp multiply_items(true, _items, _items_params), do: {:error, "invalid ids!"}

  defp multiply_items(false, items, items_params) do
    items =
      Enum.reduce(items_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        item = Map.get(items, id)

        acc ++ List.duplicate(item, quantity)
      end)

    {:ok, items}
  end

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = order), do: order
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
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
#   ],
#   "user_id" => "34e5b27d-57a1-4aae-ad09-709bd563a817",
#   "address" => "Rua dos bobo",
#   "payment_method" => "credit_card",
#   "comments" => "let's go man please"
# }
