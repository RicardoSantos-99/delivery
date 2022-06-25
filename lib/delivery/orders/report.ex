defmodule Delivery.Orders.Report do
  import Ecto.Query
  alias Delivery.{Repo, Order}

  @default_batch_size 500

  def create(_filename \\ "report.csv") do
    query = from order in Order, order_by: order

    Repo.transaction(fn ->
      query
      |> Repo.stream(max_rows: @default_batch_size)
      |> Stream.chunk_every(@default_batch_size)
      |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
      |> Enum.into([])
    end)
  end
end
