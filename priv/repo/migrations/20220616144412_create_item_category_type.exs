defmodule Delivery.Repo.Migrations.CreateItemCategoryType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE item_category_type AS ENUM ('food', 'drink', 'desert')"
    down_query = "DROP TYPE item_category_type"

    execute(up_query, down_query)
  end
end
