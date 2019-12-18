defmodule ImpressionerWeb.PanelController do
  use ImpressionerWeb, :controller

  plug :put_layout, "panel.html"

  def index(conn, _params) do
    live_render(conn, ImpressionerWeb.PanelLive, session: %{}, )
  end
end
