defmodule ImpressionerWeb.PageController do
  use ImpressionerWeb, :controller

  def slides(conn, _params) do
    render(conn, "slides.html")
  end

  def control_panel(conn, _params) do
    render(conn, "control_panel.html")
  end
end
