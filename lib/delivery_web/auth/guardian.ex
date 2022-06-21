defmodule DeliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :delivery

  alias Delivery.User
  alias Delivery.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end
end
