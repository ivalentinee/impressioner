defmodule ImpressionerWeb.ControlChannel do
  use Phoenix.Channel

  def join("control", _message, socket) do
    current_slide = Impressioner.SlideSession.get()
    {:ok, %{"slide" => current_slide}, socket}
  end

  def handle_in("show slide", %{"slide" => slide}, socket) do
    broadcast!(socket, "show slide", %{"slide" => slide})
    Impressioner.SlideSession.set(slide)
    {:noreply, socket}
  end
end
