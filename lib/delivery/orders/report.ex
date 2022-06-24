defmodule Delivery.Orders.Report do
  import Ecto.Query
  alias Delivery.{Repo, Order}

  def create(_filename \\ "report.csv") do
    query = from order in Order, order_by: order

    Repo.transaction(fn ->
      query
      |> Repo.stream()
      |> Enum.into([])
      |> IO.inspect()
    end)
  end
end
