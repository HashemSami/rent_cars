defmodule RentCarsWeb.Router do
  use RentCarsWeb, :router

  alias RentCarsWeb.Api.Middleware.IsAdmin
  alias RentCarsWeb.Api.Middleware.EnsureAuthenticated

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

  pipeline :is_admin do
    plug IsAdmin
  end

  pipeline :authenticated do
    plug EnsureAuthenticated
  end

  scope "/", RentCarsWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/categories", CategoryController, :home
  end

  # Other scopes may use custom stacks.
  scope "/api", RentCarsWeb.Api, as: :api do
    pipe_through :api

    scope "/admin", Admin, as: :admin do
      pipe_through :is_admin

      get "/categories", CategoryController, :index
      post "/categories", CategoryController, :create
      get "/categories/:id", CategoryController, :show
      put "/categories/:id", CategoryController, :update
      delete "/categories/:id", CategoryController, :delete

      post "/cars", CarController, :create
      get "/cars/:id", CarController, :show
      put "/cars/:id", CarController, :update

      resources "/specifications", SpecificationController
    end

    scope "/" do
      pipe_through :authenticated
      get "/users/:id", UserController, :show
      post "/sessions/me", SessionController, :me
    end

    post "/users", UserController, :create
    post "/sessions", SessionController, :create
    post "/sessions/forgot_password", SessionController, :forgot_password
    post "/sessions/reset_password", SessionController, :reset_password
  end

  # coveralls-ignore-start
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

  # coveralls-ignore-stop
end
