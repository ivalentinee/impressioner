defmodule ImpressionerWeb.SlidesController do
  use ImpressionerWeb, :controller

  plug :put_layout, "slides.html"

  def index(conn, _params) do
    live_render(conn, ImpressionerWeb.SlidesLive, session: %{}, )
  end
end
