defmodule ImpressionerWeb.SlidesLive do
  use Phoenix.HTML
  use Phoenix.LiveView
  alias Impressioner.Slides
  alias ImpressionerWeb.SlidesView
  alias Phoenix.Socket.Broadcast
  alias Phoenix.View

  def render(assigns) do
    View.render(SlidesView, "index.html", assigns)
  end

  def handle_info(%Broadcast{event: "updated", payload: %{slide: slide}, topic: "slides"}, socket) do
    {:noreply, assign(socket, slide: slide)}
  end

  def mount(_session, socket) do
    Slides.subscribe()
    {:ok, assign(socket, slide: Slides.get())}
  end
end
