ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Delivery.Repo, :manual)

Mox.defmock(Delivery.ViaCep.ClientMock, for: Delivery.ViaCep.Behaviour)
