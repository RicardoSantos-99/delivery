defmodule DeliveryWeb.Router do
  use DeliveryWeb, :router

  alias DeliveryWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  scope "/api", DeliveryWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    post "/users/signin", UsersController, :sign_in
    resources "/users", UsersController, except: [:new, :edit]
    resources "/items", ItemsController, except: [:new, :edit]
    resources "/orders", OrdersController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: DeliveryWeb.Telemetry
    end
  end
end
