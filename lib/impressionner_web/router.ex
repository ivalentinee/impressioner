defmodule ImpressionnerWeb.Router do
  use ImpressionnerWeb, :router

  pipeline :browser do
    plug :fetch_session
    plug :protect_from_forgery
  end

  scope "/", ImpressionnerWeb do
    pipe_through :browser
  end
end
