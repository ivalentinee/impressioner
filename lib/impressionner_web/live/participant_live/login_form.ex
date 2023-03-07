defmodule ImpressionnerWeb.ParticipantLive.LoginForm do
  use ImpressionnerWeb, :live_component

  def mount(socket) do
    {:ok, assign(socket, :form, %{})}
  end

  def handle_event("validate", params, socket), do: {:noreply, socket}

  def handle_event("login", params, socket) do
    username = params["username"]

    if (is_binary(username) && String.length(username) > 0) do
      send self(), {:login, username}
    end

    {:noreply, socket}
  end
end
