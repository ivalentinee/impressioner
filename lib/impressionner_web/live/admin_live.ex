defmodule ImpressionnerWeb.AdminLive do
  use ImpressionnerWeb, :live_view

  alias Impressionner.Contexts.Users

  def mount(_params, _session, socket) do
    users = Users.all()
    Users.subscribe()
    {:ok, assign(socket, :users, users)}
  end

  def handle_info(%{topic: "users"}, socket) do
    updated_users = Users.all()
    {:noreply, assign(socket, :users, updated_users)}
  end
end
