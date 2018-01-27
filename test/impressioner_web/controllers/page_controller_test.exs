defmodule ImpressionerWeb.PageControllerTest do
  use ImpressionerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end

  test "GET /panel", %{conn: conn} do
    conn = get(conn, "/panel")
    assert html_response(conn, 200)
  end
end
