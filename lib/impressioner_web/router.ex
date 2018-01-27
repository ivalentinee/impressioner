defmodule ImpressionerWeb.Router do
  use ImpressionerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ImpressionerWeb do
    pipe_through(:browser)
    get("/", PageController, :slides)
    get("/panel", PageController, :control_panel)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ImpressionerWeb do
  #   pipe_through :api
  # end
end
