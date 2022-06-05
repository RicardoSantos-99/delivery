defmodule Delivery.Repo do
  use Ecto.Repo,
    otp_app: :delivery,
    adapter: Ecto.Adapters.Postgres
end
