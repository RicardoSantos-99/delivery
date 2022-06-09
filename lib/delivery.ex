defmodule Delivery do
  alias Delivery.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end
