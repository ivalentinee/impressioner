defmodule ImpressionerWeb.ControlChannel do
  use Phoenix.Channel

  def join("control", _message, socket) do
    {:ok, socket}
  end

  def handle_in("show slide", %{"slide" => slide}, socket) do
    broadcast!(socket, "show slide", %{"slide" => slide})
    {:noreply, socket}
  end
end
