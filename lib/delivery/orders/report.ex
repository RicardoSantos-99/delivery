defmodule Delivery.Orders.Report do
  import Ecto.Query
  alias Delivery.{Repo, Order, Item}

  @default_batch_size 500

  def create(_filename \\ "report.csv") do
    query = from order in Order, order_by: order

    Repo.transaction(fn ->
      query
      |> Repo.stream(max_rows: @default_batch_size)
      |> Stream.chunk_every(@default_batch_size)
      |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
      |> Enum.map(&parse_line/1)
    end)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    items_string = Enum.map(items, &item_string/1)

    "#{user_id},#{payment_method},#{items_string}#{50.0}"
  end

  defp item_string(%Item{category: category, description: description, price: price}) do
    "#{category},#{description},#{price},"
  end
end
