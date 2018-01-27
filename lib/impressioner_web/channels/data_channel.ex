defmodule ImpressionerWeb.DataChannel do
  use Phoenix.Channel

  def join("data", _message, socket) do
    {:ok, socket}
  end

  def handle_in("get slides", _, socket) do
    slides = Impressioner.SlideList.list()
    {:reply, {:ok, %{slides: slides}}, socket}
  end
end
