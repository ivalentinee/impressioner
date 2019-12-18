defmodule ImpressionerWeb.PanelLive do
  use Phoenix.HTML
  use Phoenix.LiveView
  alias Impressioner.Slides
  alias ImpressionerWeb.PanelView
  alias Phoenix.Socket.Broadcast
  alias Phoenix.View

  def render(assigns) do
    View.render(PanelView, "index.html", assigns)
  end

  def handle_event("next_slide", _, socket) do
    Slides.next()
    {:noreply, socket}
  end

  def handle_event("prev_slide", _, socket) do
    Slides.prev()
    {:noreply, socket}
  end

  def handle_info(%Broadcast{event: "updated", payload: %{slide: slide}, topic: "slides"}, socket) do
    {:noreply, assign(socket, slide: slide)}
  end

  def mount(_session, socket) do
    Slides.subscribe()
    {:ok, assign(socket, slide: Slides.get())}
  end
end
