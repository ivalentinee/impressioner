defmodule ImpressionerWeb.PageController do
  use ImpressionerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
