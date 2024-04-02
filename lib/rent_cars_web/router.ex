defmodule RentCarsWeb.Router do
  use RentCarsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RentCarsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RentCarsWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/categories", CategoryController, :home
  end

  # Other scopes may use custom stacks.
  scope "/api", RentCarsWeb.Api, as: :api do
    pipe_through :api

    get "/categories", CategoryController, :index
    post "/categories", CategoryController, :create
    get "/categories/:id", CategoryController, :show
    put "/categories/:id", CategoryController, :update
    delete "/categories/:id", CategoryController, :delete
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:rent_cars, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RentCarsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
