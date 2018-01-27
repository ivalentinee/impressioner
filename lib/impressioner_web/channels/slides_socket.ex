defmodule ImpressionerWeb.SlidesSocket do
  use Phoenix.Socket

  channel "data", ImpressionerWeb.DataChannel

  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
