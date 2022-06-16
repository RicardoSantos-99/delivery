defmodule Delivery do
  alias Delivery.Items.Create, as: ItemCreate

  alias Delivery.Users.Create, as: UserCreate
  alias Delivery.Users.Get, as: UserGet
  alias Delivery.Users.Delete, as: UserDelete
  alias Delivery.Users.Update, as: UserUpdate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate update_user(params), to: UserUpdate, as: :call

  defdelegate create_item(params), to: ItemCreate, as: :call
end
