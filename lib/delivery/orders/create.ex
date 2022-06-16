defmodule Delivery.Orders.Create do
  import Ecto.Query
  alias Delivery.{Error, Repo, Order, Item}
  alias Delivery.Orders.ValidateAndMultiplyItems

  def call(%{"items" => items_params} = params) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(items_ids, items_params)
    |> handle_items(params)
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
