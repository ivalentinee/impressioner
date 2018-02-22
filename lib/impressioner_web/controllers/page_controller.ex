defmodule ImpressionerWeb.PageController do
  use ImpressionerWeb, :controller

  plug(
    BasicAuth,
    [use_config: {:impressioner, :control_panel_auth}] when action == :control_panel
  )

  plug(BasicAuth, [use_config: {:impressioner, :slides_auth}] when action == :slides)

  def slides(conn, _params) do
    render(conn, "slides.html")
  end

  def control_panel(conn, _params) do
    render(conn, "control_panel.html")
  end
end
